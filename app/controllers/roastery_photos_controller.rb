class RoasteryPhotosController < ApplicationController
  before_action :set_roastery

  def create
    if params[:roastery][:photos]
      @roastery.photos.attach(params[:roastery][:photos])
      flash[:notice] = "Photos uploaded successfully!"
    else
      flash[:alert] = "Please select at least one photo."
    end
    redirect_to @roastery
  end

  private

  def set_roastery
    @roastery = Roastery.find(params[:roastery_id])
  end
end
