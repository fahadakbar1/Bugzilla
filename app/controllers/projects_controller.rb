# frozen_string_literal: true

class ProjectsController < ApplicationController
  include Projectconcerns

  before_action :authenticate_user!, except: [:welcome]
  before_action :find_current_user, only: %i[create destroy update]
  before_action :project_by_id, only: %i[show edit update]

  def welcome; end

  def index
    @projects = Project.all
  end

  def show
    developers_and_qas
  end

  def new
    @project = Project.new
    render 'new'
  end

  def edit; end

  def create
    create_new_project
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: ' Project has been created successfully ' }
        format.json { render :show, status: :created, location: @project}
      else
        format.html do
          flash[:alert] = 'Project was not created'
          render 'new'
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: ' Project has been updated successfully ' }
        format.json {render :show, status: :ok, location: @project}
      else
        format.html do
          flash[:alert] = 'Project was not updated'
          render 'edit'
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    find_destroy_project
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_path, notice: ' Project has been deleted successfully ' }
        format.json {head :no_content}
      else
        format.html { redirect_to project_path, notice: ' Project was not deleted ' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
