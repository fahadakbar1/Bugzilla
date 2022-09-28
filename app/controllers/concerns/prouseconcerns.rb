# frozen_string_literal: true

module Prouseconcerns
  extend ActiveSupport::Concern

  def select_developer
    @dev = params[:developer_for_this_project]
    @developers = User.with_role :Developer
    @projid = params[:project]
    @developer = @developers.find_by(username: @dev)
  end

  def select_qa
    @qa = params[:qas_for_this_project]
    @qas = User.with_role :QA
    @projid = params[:project]
    @selected_qa = @qas.find_by(username: @qa)
  end
end
