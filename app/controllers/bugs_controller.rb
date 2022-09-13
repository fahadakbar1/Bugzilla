# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :bug_by_id, only: %i[update]
  before_action :project_by_project_id, only: %i[new create update destroy]
  before_action :create_bug, only: %i[create]
  before_action :project_by_id, only: %i[edit]
  before_action :bug_by_project_id, only: %i[edit show]
  before_action :bug_by_bid, only: %i[markcomplete assign]
  before_action :project_by_pid, only: %i[assign markcomplete]

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

  def bug_by_project_id
    @bug = Bug.find(params[:project_id])
  end

  def project_by_id
    @project = Project.find(params[:id])
  end

  def bug_by_id
    @bug = Bug.find(params[:id])
  end

  def bug_by_bid
    @bug = Bug.find(params[:bid])
  end

  def project_by_pid
    @project = Project.find(params[:pid])
  end

  def project_by_project_id
    @project = Project.find(params[:project_id])
  end

  def create_bug
    @user = User.find(current_user.id)
    @bug = @project.bugs.new(bug_params)
    @bug.user_id = current_user.id
  end
end
