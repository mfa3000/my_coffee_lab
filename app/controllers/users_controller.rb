class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
    @favourites = {
      beans: @user.favourite_beans,
      places: @user.favourite_roasteries
    }
    @user_beans = @user.beans
    @user_places = @user.roasteries

  end

end
