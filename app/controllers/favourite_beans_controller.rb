class FavouriteBeansController < ApplicationController
  before_action :authenticate_user!

  def create
    @bean = Bean.find(params[:bean_id])
    current_user.favourite_beans.create(bean: @bean)

    respond_to do |format|
      format.json { render json: { favorited: true } }
      format.html { redirect_to @bean }
    end
  end

  def destroy
    @bean = Bean.find(params[:bean_id])
    current_user.favourite_beans.find_by(bean: @bean)&.destroy

    respond_to do |format|
      format.json { render json: { favorited: false } }
      format.html { redirect_to @bean }
    end
  end
end
