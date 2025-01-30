class RoasteriesController < ApplicationController
  before_action :set_roastery, only: [:show, :destroy]
  before_action :authorize_user, only: [:destroy]


  def show
  end

  def index
    @roasteries = Roastery.includes(:locations).all
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

  def destroy
    if @roastery.destroy
      redirect_to request.referer&.include?(profile_path) ? profile_path : roasteries_path,
                  notice: "Roastery successfully deleted."
    else
      redirect_to roasteries_path, alert: "Failed to delete the Roastery."
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

  def authorize_user
    unless user_authorized_to_delete?(@roastery)
      redirect_to roastery_path, alert: "You are not authorized to delete this Roastery."
    end
  end

end
