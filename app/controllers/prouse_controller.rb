# frozen_string_literal: true

class ProuseController < ApplicationController
  include Prouseconcerns

  before_action :select_developer, only: %i[add_developer remove_developer]
  before_action :select_qa, only: %i[add_qa remove_qa]

  def add_developer

    respond_to do |format|
    if @developer.nil?
      format.html { redirect_to project_path(@projid), notice: 'Please select any developer to be added' }
      format.json { render json: @project.errors, status: :unprocessable_entity }

    elsif Prouse.exists?(Prouse.check_existing_developer(params[:project], @developer.id))
      format.html { redirect_to project_path(@projid), notice: "#{@dev} is already the developer of this project" }
      format.json { render :show, status: :ok, location: @project }
    else
      Prouse.create(project_id: params[:project], user_id: @developer.id)
      format.html { redirect_to project_path(@projid), notice: "Developer #{@dev} has been added to this project" }
      format.json { render :show, status: :ok, location: @project }
    end
  end
end

  def add_qa
    respond_to do |format|
    if @selected_qa.nil?
      format.html { redirect_to project_path(@projid), notice: 'Please select any QA to be added' }
      format.json { render json: @project.errors, status: :unprocessable_entity }

    elsif Prouse.exists?(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      format.html { redirect_to project_path(@projid), notice: "#{@qa} is already the QA of this project" }
      format.json { render :show, status: :ok, location: @project }
    else
      Prouse.create(project_id: params[:project], user_id: @selected_qa.id)
      format.html { redirect_to project_path(@projid), notice: "QA #{@qa} has been added to this project" }
      format.json { render :show, status: :ok, location: @project }
    end
  end
end

  def remove_developer
    respond_to do |format|
    if @developer.nil?
      format.html { redirect_to project_path(@projid), notice: 'Please select any developer to be removed' }
      format.json { render json: @project.errors, status: :unprocessable_entity }

    elsif Prouse.exists?(Prouse.check_existing_developer(params[:project], @developer.id))
      Prouse.delete(Prouse.check_existing_developer(params[:project], @developer.id))
      format.html {redirect_to project_path(@projid), notice: "Developer #{@dev} has been removed from this project"}
      format.json { render :show, status: :ok, location: @project }

    else
      format.html { redirect_to project_path(@projid), notice: "#{@dev} is not the developer of this project" }
      format.json { render :show, status: :ok, location: @project }

    end
  end
end

  def remove_qa
    respond_to do |format|
    if @selected_qa.nil?
      format.html { redirect_to project_path(@projid), notice: 'Please select any QA to be removed' }
      format.json { render json: @project.errors, status: :unprocessable_entity }

    elsif Prouse.exists?(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      Prouse.delete(Prouse.check_existing_developer(params[:project], @selected_qa.id))
      format.html { redirect_to project_path(@projid), notice: "QA #{@qa} has been removed from this project" }
      format.json { render :show, status: :ok, location: @project }

    else
      redirect_to project_path(@projid), notice: "#{@qa} is not the QA of this project"
      format.json { render :show, status: :ok, location: @project }
    end
  end
end
end

