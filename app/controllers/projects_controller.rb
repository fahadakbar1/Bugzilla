# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :fetch_project, only: %i[show edit]
  before_action :fetch_user, only: %i[create destroy update]

  def welcome; end

  def index
    @projects = Project.all
  end

  def show
    fetch_project
    @developers = User.with_role :Developer
    @qas = User.with_role :QA
  end

  def new
    @project = Project.new
    render 'new'
  end

  def edit; end

  def create
    fetch_user
    @project = @user.projects.new(project_params)
    authorize @project
    if @project.save
      redirect_to @project
    else
      redirect_to new_project_url, notice: ' Project was not created '
    end
  end

  def update
    fetch_project
    if @project.update(project_params)
      redirect_to @project
    else
      redirect_to edit_project_url, notice: ' Project was not updated '
    end
  end

  def destroy
    fetch_project
    if @project.destroy
      redirect_to projects_path
    else
      redirect_to project_path, notice: ' Project was not deleted '
    end
  end

  private

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
