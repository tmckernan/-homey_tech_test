# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_project, only: :create

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @project.comments.new(comment_params)
    if @comment.save
      redirect_to project_path(@project), notice: 'Comment added'
    else
      redirect_to project_path(@project), alert: 'error happen'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to project_path(@comment.project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @project = @comment.project
    @comment.destroy
    redirect_to project_path(@project), status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
