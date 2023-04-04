# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show
    @comment = Comment.new
    @comments = @project.comments
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'Project has been successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update({ status: params[:status] })
      Comment.create(
        content: "Status has been updated to: #{@project.status.humanize}",
        user_id: current_user.id,
        project_id: @project.id
      )
      redirect_to project_path(@project), notice: 'Project has been successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project has been successfully destroyed.'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status).merge(user_id: current_user.id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
