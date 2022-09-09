# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_bug, only: %i[create]
  before_action :resolved_or_completed, only: [:markcomplete]

  def new
    @bug = Bug.new
    @project = Project.find(params[:project_id])
  end

  def edit
    @bug = Bug.find(params[:project_id])
    @project = Project.find(params[:id])
  end

  def show
    @bug = Bug.find(params[:project_id])
  end

  def create
    authorize @bug
    if @bug.save
      redirect_to project_path(@project)
    else
      redirect_to new_bug_url, notice: ' Project was not created '
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
    authorize @bug
    if @bug.update(bug_params)
      redirect_to @project
    else
      redirect_to edit_bug_url, notice: ' Bug was not updated '
    end

  end

  def destroy
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.find(params[:id])
    authorize @bug

    if @bug.destroy
    redirect_to project_path(@project)
  else
    redirect_to project_path(@project), notice: ' Bug was not destroyed '
  end
  end

  def assign
    @bug = Bug.find(params[:bid])
    @bug.dev_id = current_user.id
    @bug.status = 1
    if @bug.save
    @project = Project.find(params[:pid])
    redirect_to @project
  else
    redirect_to project_path(@project), notice: ' Bug was not assigned '
  end

  def markcomplete
    @project = Project.find(params[:pid])
    redirect_to @project
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bugtype, :status)
  end

  def resolved_or_completed
    @bug = Bug.find(params[:bid])
    @bug.user_id = current_user.id
    @bug.status = if @bug.bugtype == 'Bug'
                    2
                  else
                    3
                  end
    @bug.save
  end

  def fetch_bug
    @user = User.find(current_user.id)
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)
    @bug.user_id = current_user.id
  end
end
