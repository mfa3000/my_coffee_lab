class BeanCommentVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bean_comment

  def create
    @bean_comment_vote = @bean_comment.bean_comment_votes.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @bean_comment.bean }
    end
  end

  def destroy
    @bean_comment_vote = @bean_comment.bean_comment_votes.find_by(user: current_user)
    @bean_comment_vote.destroy if @bean_comment_vote

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @bean_comment.bean, notice: "Unliked!" }
    end
  end

  private

  def set_bean_comment
    @bean_comment = BeanComment.find(params[:bean_comment_id])
  end
end
