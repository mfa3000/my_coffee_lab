class BeanCommentVotesController < ApplicationController
  before_action :set_bean_comment

  def create
    current_user.like(@bean_comment)
    respond_to do |format|
      format.json { render json: { liked: true, count: @bean_comment.likes_count } }
    end
  end

  def destroy
    current_user.unlike(@bean_comment)
    respond_to do |format|
      format.json { render json: { liked: false, count: @bean_comment.likes_count } }
    end
  end

  private

  def set_bean_comment
    @bean_comment = BeanComment.find(params[:bean_comment_id])
  end
end
