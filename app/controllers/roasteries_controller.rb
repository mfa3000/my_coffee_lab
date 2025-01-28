class RoasteriesController < ApplicationController
  before_action :set_roastery, only: [:show]
  
  def show
  end
  
  def index
    @roasteries = Roastery.all
  end

private

  def set_roastery
    @roastery = Roastery.find(params[:id])
  end

end
