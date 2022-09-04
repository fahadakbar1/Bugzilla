# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authenticate_user!

  before_action :resolved_or_completed, only: [:markcomplete]

  def new
    @bug = Bug.new
    @project = Project.find(params[:project_id])
  end

  def edit
    @bug = Bug.find(params[:project_id])
    @project = Project.find(params[:id])
  end

  def create
    @user = User.find(current_user.id)
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)
    authorize @bug
    if @bug.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
    @bug.update(bug_params)
    redirect_to @project
  end

  def destroy
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.find(params[:id])
    @bug.destroy
    redirect_to project_path(@project)
  end

  def assign
    @bug = Bug.find(params[:bid])
    @bug.user_id = current_user.id
    @bug.status = 1
    @bug.save
    @project = Project.find(params[:pid])
    redirect_to @project
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
    @bug.status = if @bug.bugtype == 'bug'
                    2
                  else
                    3
                  end
    @bug.save
  end
end
