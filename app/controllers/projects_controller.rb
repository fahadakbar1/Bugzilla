# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :fetch_user, only: %i[create destroy update]
   before_action :fetch_create_project, only: %i[create]
  before_action :fetch_project, only: %i[show edit update]
  before_action :fetch_destroy_project, only: %i[destroy]

  def welcome; end

  def index
    @projects = Project.all
  end

  def show
    @developers = User.with_role :Developer
    @qas = User.with_role :QA
  end

  def new
    @project = Project.new
    render 'new'
  end

  def edit; end

  def create
    authorize @project
    if @project.save
      redirect_to @project, notice: ' Project has been created successfully '
    else
      redirect_to new_project_url, notice: ' Project was not created '
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: ' Project has been updated successfully '
    else
      redirect_to edit_project_url, notice: ' Project was not updated '
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: ' Project has been destroyed successfully '
    else
      redirect_to project_path, notice: ' Project was not deleted '
    end
  end

private
  def fetch_create_project
    @project = @user.projects.new(project_params)
  end

  def fetch_destroy_project
    @project = @user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def fetch_project
    @project = Project.find(params[:id])
  end

  def fetch_user
    @user = User.find(current_user.id)
  end
end
