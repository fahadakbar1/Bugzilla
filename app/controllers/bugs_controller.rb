# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_bug, only: %i[update]
  before_action :original_project, only: %i[new create update destroy]
  before_action :current_user_bug, only: %i[create]
  before_action :current_project, only: %i[edit]
  before_action :project_bug, only: %i[edit show]
  before_action :developer_bug, only: %i[markcomplete assign]
  before_action :developer_project, only: %i[assign markcomplete]

  def new
    @bug = Bug.new
  end

  def edit; end

  def show; end

  def create
    authorize @bug
    if @bug.save
      redirect_to project_path(@project), notice: ' New bug has been added to this project '
    else
      render 'new', notice: ' Bug was not created '
      # redirect_to new_project_bug_url , notice: 'Bug was not created'
    end
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      redirect_to @project, notice: ' Bug was updated successfully '
    else
      render 'edit', notice: ' Bug was not updated '
    end
  end

  def destroy
    @bug = @project.bugs.find(params[:id])
    authorize @bug

    if @bug.destroy
      redirect_to project_path(@project), notice: ' Bug was destroyed successfully '
    else
      redirect_to project_path(@project), notice: ' Bug was not destroyed '
    end
  end

  def assign
    @bug.dev_id = current_user.id
    @bug.status = 1
    if @bug.save
      redirect_to @project, notice: ' Bug has been assigned to you '
    else
      redirect_to project_path(params[:pid]), notice: ' Bug was not assigned '
    end
  end

  def markcomplete
    @bug.user_id = current_user.id
    @bug.status = if @bug.bugtype == 'Bug'
                    2
                  else
                    3
                  end
    if @bug.save
      redirect_to @project, notice: ' Bug has been completed '
    else
      redirect_to @project, notice: ' Bug was not completed '
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bugtype, :status)
  end

  def project_bug
    @bug = Bug.find(params[:project_id])
  end

  def current_project
    @project = Project.find(params[:id])
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def developer_bug
    @bug = Bug.find(params[:bid])
  end

  def developer_project
    @project = Project.find(params[:pid])
  end

  def original_project
    @project = Project.find(params[:project_id])
  end

  def current_user_bug
    @user = User.find(current_user.id)
    @bug = @project.bugs.new(bug_params)
    @bug.user_id = current_user.id
  end
end
