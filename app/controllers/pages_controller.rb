class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @roasteries = Roastery.all
    @beans = Bean.all


    if params[:location].present?
      @roasteries = @roasteries.joins(:locations).where(locations: { city: params[:location] })
    end
  end
end
