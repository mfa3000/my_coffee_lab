class BeansController < ApplicationController
  before_action :set_bean, only: [:show]

  def show
  end

  def index
    @bean = Bean.all
  end

private

  def set_bean
    @bean = Bean.find(params[:id])
  end

end
