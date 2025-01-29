class PagesController < ApplicationController
  def home
    @roasteries = Roastery.all
    @beans = Bean.all

    if params[:location].present?
      @roasteries = @roasteries.joins(:locations).where(locations: { city: params[:location] })
    end
  end
end
