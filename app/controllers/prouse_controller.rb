# frozen_string_literal: true

class ProuseController < ApplicationController
  before_action :select_developer, only: %i[add_developer remove_developer]
  before_action :select_qa, only: %i[add_qa remove_qa]

  def add_developer
    if Prouse.exists?(Prouse.check_existing_developer(params[:project], @developer.id))
      redirect_to project_path(@projid), notice: "#{@dev} is already the developer of this project"
    else
      Prouse.create(project_id: params[:project], user_id: @developer.id)
      redirect_to project_path(@projid), notice: "Developer #{@dev} has been added to this project"
    end
  end

  def add_qa
    if Prouse.exists?(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      redirect_to project_path(@projid), notice: "#{@qa} is already the QA of this project"
    else
      Prouse.create(project_id: params[:project], user_id: @selected_qa.id)
      redirect_to project_path(@projid), notice: "QA #{@qa} has been added to this project"
    end
  end

  def remove_developer
    if Prouse.exists?(Prouse.check_existing_developer(params[:project], @developer.id))
      Prouse.delete(Prouse.check_existing_developer(params[:project], @developer.id))
      redirect_to project_path(@projid), notice: "Developer #{@dev} has been removed from this project"

    else
      redirect_to project_path(@projid), notice: "#{@dev} is not the developer of this project"
    end
  end

  def remove_qa
    if Prouse.exists?(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      Prouse.delete(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      redirect_to project_path(@projid), notice: "QA #{@qa} has been removed from this project"
    else
      redirect_to project_path(@projid), notice: "#{@qa} is not the QA of this project"
    end
  end

  private

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
