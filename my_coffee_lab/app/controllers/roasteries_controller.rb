class RoasteriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @roastery = Roastery.new
  end

  def create
    @roastery = current_user.roasteries.build(roastery_params)
    if @roastery.save
      redirect_to roastery_path(@roastery), notice: 'Roastery successfully created!'
    else
      flash.now[:alert] = 'There was an error creating the roastery.'
      render :new
    end
  end

  private

  def roastery_params
    params.require(:roastery).permit(:name, :description, :image, :address, :roastery_url)
  end
end
