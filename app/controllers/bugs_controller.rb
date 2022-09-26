# frozen_string_literal: true

class BugsController < ApplicationController
  include Foo

  before_action :authenticate_user!
  before_action :original_project, only: %i[new create update destroy]
  before_action :current_project, only: %i[edit show]

  def new
    @bug = Bug.new
  end

  def edit; end

  def show; end

  def create
    current_user_bug
    authorize @bug

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_path(@project), notice: ' New bug has been added to this project ' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html do
          flash[:alert] = 'Bug was not created'
          render 'new'
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
        # redirect_to new_project_bug_url , notice: 'Bug was not created'
      end
    end
  end

  def update
    @bug = Bug.find(params[:id])
    authorize @bug
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @project, notice: ' Bug was updated successfully ' }
        format.json { render json: @project, status: :updated, location: @project }
      else
        format.html do
          flash[:alert] = 'Bug was not updated'
          render 'edit'
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bug = @project.bugs.find(params[:id])
    authorize @bug
    respond_to do |format|
      if @bug.destroy
        format.html { redirect_to project_path(@project), notice: ' Bug was deleted successfully ' }
        format.json { render json: @project, status: :destroyed, location: @project }
      else
        format.html { redirect_to project_path(@project), notice: ' Bug was not deleted ' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign
    developer_bug
    @bug.dev_id = current_user.id
    @bug.status = 1
    respond_to do |format|
      if @bug.save
        format.html { redirect_to @project, notice: ' Bug has been assigned to you ' }
        format.json { render json: @project, status: :assigned, location: @project }
      else
        format.html { redirect_to project_path(params[:pid]), notice: ' Bug was not assigned ' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def markcomplete
    developer_bug
    @bug.status = if @bug.bugtype == 'bug'
                    2
                  else
                    3
                  end
    respond_to do |format|
      if @bug.save
        format.html { redirect_to @project, notice: ' Bug has been completed ' }
        format.json { render json: @project, status: :Completed, location: @project }
      else
        format.html { redirect_to @project, notice: ' Bug was not completed ' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bugtype, :status)
  end
end
