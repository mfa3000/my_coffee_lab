class BeanCommentVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @bean_comment = BeanComment.find(params[:bean_comment_id])
    vote = @bean_comment.bean_comment_votes.find_or_initialize_by(user: current_user)

    vote.vote = true

    if vote.save
      redirect_to bean_path(@bean_comment.bean)
      #render json: { votes_count: @bean_comment.bean_comment_votes.where(vote: true).count }
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @bean_comment = BeanComment.find(params[:bean_comment_id])
    vote = @bean_comment.bean_comment_votes.find_by(user: current_user)

    if vote&.destroy
      redirect_to bean_path(@bean_comment.bean), status: :see_other
      #render json: { votes_count: @bean_comment.bean_comment_votes.where(vote: true).count }
    else
      head :unprocessable_entity
    end
  end
end
