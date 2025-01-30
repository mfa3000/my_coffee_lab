class BeanReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bean

  def create
    @review = @bean.bean_reviews.find_or_initialize_by(user: current_user)
    @review.rating = params[:bean_review][:rating]

    if @review.save
      render json: { success: true, rating: @review.rating, average_rating: @bean.average_rating }
    else
      render json: { success: false, errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_bean
    @bean = Bean.find(params[:bean_id])
  end
end
