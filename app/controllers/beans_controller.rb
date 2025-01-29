class BeansController < ApplicationController

  before_action :authenticate_user!
  before_action :set_bean, only: [:show, :edit, :update]


  def show
  end

  def index
    @beans = Bean.all

    @beans = @beans.where(brewing_method: params[:brewing_method]) if params[:brewing_method].present?
    @beans = @beans.where(roast_level: params[:roast_level]) if params[:roast_level].present?
    @beans = @beans.where(origin: params[:origin]) if params[:origin].present?
    @beans = @beans.where(flavour: params[:flavour]) if params[:flavour].present?
  end

  def new
    @bean = Bean.new
  end

  def edit
  end


  def create
    @bean = current_user.beans.build(bean_params)

    if @bean.save
      redirect_to bean_path(@bean), notice: "Bean successfully created!"
    else
      if @bean.errors[:roastery_id].present?
        flash.now[:alert] = "Roastery can't be blank"
      else
        flash.now[:alert] = @bean.errors.full_messages.to_sentence
      end
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bean.update(bean_params)
      redirect_to bean_path(@bean), notice: "Bean successfully updated!"
    else
      flash.now[:alert] = @bean.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def bean_params
    params.require(:bean).permit(:name, :description, :image, :roast_level, :brewing_method, :roastery_id)
  end

  def set_bean
    @bean = Bean.find(params[:id])
  end
end
