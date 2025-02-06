class UsersController < ApplicationController
  # before_a has_many :favourite_beans, dependent: :destroy

  # has_many :favourite_beans, dependent: :destroy
  # has_many :favourite_beans, through: :favourite_beans, source: :bean

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
