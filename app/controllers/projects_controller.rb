# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]

  def welcome; end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @developers = User.with_role :Developer
    @qas = User.with_role :QA
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @user = User.find(current_user.id)
    @project = @user.projects.new(project_params)
    authorize @project
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @project = @user.projects.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
