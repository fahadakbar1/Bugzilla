# frozen_string_literal: true

module Projectconcerns
  extend ActiveSupport::Concern

  def project_by_id
    @project = Project.find(params[:id])
    @project_developers = @project.users.with_role(:Developer).pluck(:username)
    @project_qas = @project.users.with_role(:QA).pluck(:username)
  end

  def find_current_user
    @user = User.find(current_user.id)
  end

  def find_destroy_project
    @project = @user.projects.find(params[:id])
  end

  def developers_and_qas
    @developers = User.with_role :Developer
    @qas = User.with_role :QA
    @all_developers = @developers.pluck(:username)
    @all_qas = @qas.pluck(:username)
  end

  def create_new_project
    @project = @user.projects.new(project_params)
  end
end
