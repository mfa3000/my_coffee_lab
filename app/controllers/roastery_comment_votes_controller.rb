class RoasteryCommentVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_roastery_comment

  def create
    vote = @roastery_comment.roastery_comment_votes.find_or_initialize_by(user: current_user)
    vote.vote = true

    if vote.save
      render json: {
        liked: true,
        votes_count: @roastery_comment.roastery_comment_votes.where(vote: true).count
      }, status: :created
    else
      head :unprocessable_entity
    end
  end

  def destroy
    vote = @roastery_comment.roastery_comment_votes.find_by(user: current_user)

    if vote&.destroy
      render json: {
        liked: false,
        votes_count: @roastery_comment.roastery_comment_votes.where(vote: true).count
      }, status: :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def set_roastery_comment
    @roastery_comment = RoasteryComment.find(params[:roastery_comment_id])
  end
end
