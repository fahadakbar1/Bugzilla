class BugsController < ApplicationController
  #def index
  #  @bugs = Bug.all
 # end

 # def show
 #   @bug = Bug.find(params[:id])
 # end
before_action :authenticate_user!

  def assign
    @bug = Bug.find(params[:bid])
    @bug.user_id = current_user.id
    @bug.status = 1
    @bug.save
    @project=Project.find(params[:pid])
    redirect_to @project
  end


  def markcomplete
    @bug = Bug.find(params[:bid])
    @bug.user_id = current_user.id
    @bug.status = 2
    @bug.save
    @project=Project.find(params[:pid])
    redirect_to @project
  end


  def new
    @bug = Bug.new
    @project=Project.find(params[:project_id])
  end

  def edit
     @bug = Bug.find(params[:project_id])
     @project = Project.find(params[:id])
  end

  def create
    @user = User.find(current_user.id)
    @project=Project.find(params[:project_id])
    @bug = @project.bugs.create(bug_params)
    authorize @bug
    redirect_to project_path(@project)
  end

def update

  @project=Project.find(params[:project_id])
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

  private
  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screenshot, :bugtype, :status)
  end
end
