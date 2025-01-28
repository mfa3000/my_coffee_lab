class RoasteriesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create]
  def index
    @roasteries = Roastery.all
  end

  def show
    @roastery = Roastery.find(params[:id])
  end

  def new
    @roastery = Roastery.new
    @roastery.locations.build
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
    params.require(:roastery).permit(:name, :description, :image, :roastery_url, locations_attributes: [:id, :address, :location_type, :_destroy])
  end
end
