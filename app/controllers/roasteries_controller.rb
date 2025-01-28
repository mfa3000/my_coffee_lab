class RoasteriesController < ApplicationController
  before_action :set_roastery, only: [:show]
  def show

  end

private

  def set_roastery
    @roastery = Roastery.find(params[:id])
  end

end
