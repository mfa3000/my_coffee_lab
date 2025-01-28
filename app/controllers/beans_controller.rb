class BeansController < ApplicationController
<<<<<<< HEAD
  before_action :set_bean, only: [:show]

  def show
  end

  def index
    @beans = Bean.all
  end

private

  def set_bean
    @bean = Bean.find(params[:id])
  end


end
