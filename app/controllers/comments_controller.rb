class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :admin_check, only: [:destroy]

  def create
    comment = Comment.new comment_params
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    comment.commentable = commentable
    comment.user = current_user
    comment.save
    redirect_to commentable
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to companies_url and return unless @comment.commentable_type == "Company"

    @company = @comment.commentable
    @comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to company_url(@company), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def comment_params
    params.require(:comment).permit!
  end
end
