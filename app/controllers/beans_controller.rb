class BeansController < ApplicationController

  before_action :set_bean, only: [:show]

  def show
  end

  def index
    @beans = Bean.all

    @beans = @beans.where(brewing_method: params[:brewing_method]) if params[:brewing_method].present?
    @beans = @beans.where(roast_level: params[:roast_level]) if params[:roast_level].present?
    @beans = @beans.where(origin: params[:origin]) if params[:origin].present?
    @beans = @beans.where(flavour: params[:flavour]) if params[:flavour].present?
  end

private

  def set_bean
    @bean = Bean.find(params[:id])
  end


end
