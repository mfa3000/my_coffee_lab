class RoasteryReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_roastery

  def create
    @review = @roastery.roastery_reviews.find_or_initialize_by(user: current_user)
    @review.rating = params[:roastery_review][:rating]

    if @review.save
      render json: { success: true, rating: @review.rating, average_rating: @roastery.average_rating }
    else
      render json: { success: false, errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_roastery
    @roastery = Roastery.find(params[:roastery_id])
  end
end
