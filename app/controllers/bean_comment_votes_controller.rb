class BeanCommentVotesController < ApplicationController
  before_action :set_bean_comment

  def create
    @bean_comment.bean_comment_votes.create(user: current_user)
    respond_to do |format|
      format.html { redirect_to @bean_comment.bean }
      format.turbo_stream
    end
  end

  def destroy
    @bean_comment.bean_comment_votes.where(user: current_user).destroy_all
    respond_to do |format|
      format.html { redirect_to @bean_comment.bean }
      format.turbo_stream
    end
  end

  private

  def set_bean_comment
    @bean_comment = BeanComment.find(params[:bean_comment_id])
  end
end
