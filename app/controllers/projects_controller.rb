# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :find_current_user, only: %i[create destroy update]
  before_action :project_by_id, only: %i[show edit update]

  def welcome; end

  def index
    @projects = Project.all
  end

  def show
    @developers = User.with_role :Developer
    @qas = User.with_role :QA
    @all_developers = @developers.pluck(:username)
    @all_qas = @qas.pluck(:username)
  end

  def new
    @project = Project.new
    render 'new'
  end

  def edit; end

  def create
    @project = @user.projects.new(project_params)
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: ' Project has been created successfully ' }
        format.json { render json: @project, status: :created, location: @project }
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
        format.json { render json: @project, status: :updated, location: @project }
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
    @project = @user.projects.find(params[:id])
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_path, notice: ' Project has been deleted successfully ' }
        format.json { render json: @project, status: :destroyed, location: @project }
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

  def project_by_id
    @project = Project.find(params[:id])
    @project_developers = @project.users.with_role(:Developer).pluck(:username)
    @project_qas = @project.users.with_role(:QA).pluck(:username)
  end

  def find_current_user
    @user = User.find(current_user.id)
  end
end
