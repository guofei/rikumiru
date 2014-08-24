class CommentsController < ApplicationController
  def create
    comment = Comment.new comment_params
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    comment.commentable = commentable
    comment.user = current_user
    comment.save
    redirect_to commentable
  end

  private
  def comment_params
    params.require(:comment).permit!
  end
end
