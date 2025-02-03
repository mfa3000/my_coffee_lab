class BeanPhotosController < ApplicationController
  before_action :set_bean

  def create
    if params[:bean][:photos]
      @bean.photos.attach(params[:bean][:photos])
      flash[:notice] = "Photos uploaded successfully!"
    else
      flash[:alert] = "Please select at least one photo."
    end
    redirect_to @bean
  end

  private

  def set_bean
    @bean = Bean.find(params[:bean_id])
  end
end
