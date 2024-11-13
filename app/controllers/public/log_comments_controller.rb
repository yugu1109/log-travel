class Public::LogCommentsController < ApplicationController

  def create
    log = Log.find(params[:log_id])
    comment = current_user.log_comments.new(log_comment_params)
    comment.log_id = log.id
    comment.save
    redirect_to log_path(log)
  end

  def destroy
    LogComment.find(params[:id]).destroy
    redirect_to log_path(params[:log_id])
  end

  private

  def log_comment_params
    params.require(:log_comment).permit(:comment)
  end

end
