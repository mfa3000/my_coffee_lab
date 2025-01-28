class RoasteriesController < ApplicationController
  def index
    @roasteries = Roastery.all
  end

  def show
    @roastery = Roastery.find(params[:id])
  end
end
