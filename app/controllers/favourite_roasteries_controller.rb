class FavouriteRoasteriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @roastery = Roastery.find(params[:roastery_id])
    current_user.favourite_roasteries.create(roastery: @roastery)

    respond_to do |format|
      format.json { render json: { favorited: true } }
      format.html { redirect_to @roastery, notice: "Added to favourites." }
    end
  end

  def destroy
    @roastery = Roastery.find(params[:roastery_id])
    current_user.favourite_roasteries.find_by(roastery: @roastery)&.destroy

    respond_to do |format|
      format.json { render json: { favorited: false } }
      format.html { redirect_to @roastery, notice: "Removed from favourites." }
    end
  end
end
