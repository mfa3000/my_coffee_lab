class FavouriteBeansController < ApplicationController
  before_action :authenticate_user!

  def create
    @bean = Bean.find(params[:bean_id])
    current_user.favourite_beans.create(bean: @bean)

    respond_to do |format|
      format.json { render json: { favorited: true, favourites_count: @bean.favourite_beans.count } }
    end
  end

  def destroy
    @bean = Bean.find(params[:bean_id])
    current_user.favourite_beans.find_by(bean: @bean)&.destroy

    respond_to do |format|
      format.json { render json: { favorited: false, favourites_count: @bean.favourite_beans.count } }
    end
  end

end
