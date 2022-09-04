# frozen_string_literal: true

class ProuseController < ApplicationController
  before_action :fetch_selected_developer, only: %i[adddev removedev]
  before_action :fetch_selected_qa, only: %i[addqa removeqa]

  def adddev
    if Prouse.exists?(Prouse.where(project_id: params[:project], user_id: @developer.id))
      redirect_to project_path(@projid), notice: "#{@dev} is already the developer of this project"
    else
      Prouse.create(project_id: params[:project], user_id: @developer.id)
      redirect_to project_path(@projid), notice: "Developer #{@dev} has been added to this project"
    end
  end

  def addqa
    if Prouse.exists?(Prouse.where(project_id: params[:project], user_id: @selected_qa.id))
      redirect_to project_path(@projid), notice: "#{@qa} is already the QA of this project"
    else
      Prouse.create(project_id: params[:project], user_id: @selected_qa.id)
      redirect_to project_path(@projid), notice: "QA #{@qa} has been added to this project"
    end
  end

  def removedev
    if Prouse.exists?(Prouse.where(project_id: params[:project], user_id: @developer.id))
      Prouse.delete(Prouse.where(project_id: params[:project], user_id: @developer.id))
      redirect_to project_path(@projid), notice: "Developer #{@dev} has been removed from this project"
    else
      redirect_to project_path(@projid), notice: "#{@dev} is not the developer of this project"
    end
  end

  def removeqa
    if Prouse.exists?(Prouse.where(project_id: params[:project], user_id: @selected_qa.id))
      Prouse.delete(Prouse.where(project_id: params[:project], user_id: @selected_qa.id))
      redirect_to project_path(@projid), notice: "QA #{@qa} has been removed from this project"
    else
      redirect_to project_path(@projid), notice: "#{@qa} is not the QA of this project"
    end
  end

  private

  def fetch_selected_developer
    @dev = params[:developer_for_this_project]
    @developers = User.with_role :Developer
    @projid = params[:project]
    @developer = @developers.find_by(username: @dev)
  end

  def fetch_selected_qa
    @qa = params[:qas_for_this_project]
    @qas = User.with_role :QA
    @projid = params[:project]
    @selected_qa = @qas.find_by(username: @qa)
  end
end
