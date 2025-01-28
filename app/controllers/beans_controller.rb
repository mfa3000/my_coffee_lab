class BeansController < ApplicationController
  def index
    @beans = bean.all 
end
