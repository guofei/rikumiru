# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_action :authenticate_user!, only: [:destroy, :index]
  before_action :admin_check, only: [:destroy, :index]

  def index
    @comments = Comment.all.page(params[:page]).includes(:commentable)
    @count = Comment.count
  end

  def create
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    if simple_captcha_valid?
      comment = Comment.new comment_params
      comment.commentable = commentable
      comment.user = current_user
      comment.ip = ip
      comment.save
    else
      flash[:alert] = "画像に表示された文字を再入力してください。"
    end
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
    params.require(:comment).permit(:title, :comment, :captcha, :captcha_key)
  end

  def ip
    request.remote_ip
  end
end
