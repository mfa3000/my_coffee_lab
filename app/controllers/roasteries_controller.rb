class RoasteriesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create]
  before_action :set_roastery, only: [:show]

  def show
  end

  def index
    @roasteries = Roastery.includes(:locations).all

    if params[:location].present?
      @roasteries = Roastery.near(params[:location], 10)
    end
    @markers = @roasteries.map do |roastery|
      {
        lat: roastery.latitude,
        lng: roastery.longitude
      }
    end
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

  def search
    @roasteries = Roastery.where("name ILIKE ?", "%#{params[:query]}%")
    render json: @roasteries.map { |r| { id: r.id, name: r.name } }
  end

  def edit
    @roastery = Roastery.find(params[:id])
  end

  def update
    @roastery = Roastery.find(params[:id])
    if @roastery.update(roastery_params)
      redirect_to roastery_path(@roastery), notice: "Roastery successfully updated!"
    else
      flash.now[:alert] = "There was an error updating the roastery."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def roastery_params
    params.require(:roastery).permit(
      :name, :description, :image, :roastery_url,
      locations_attributes: [:id, :location_type, :address, :_destroy]
    )
  end

  def set_roastery
    @roastery = Roastery.find(params[:id])
  end
end
