# frozen_string_literal: true

module Foo
  extend ActiveSupport::Concern

  def current_project
    @project = Project.find(params[:id])
    @bug = Bug.find(params[:project_id])
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def developer_bug
    @bug = Bug.find(params[:bid])
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
