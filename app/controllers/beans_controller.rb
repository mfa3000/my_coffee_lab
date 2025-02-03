class BeansController < ApplicationController

  before_action :set_bean, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:destroy]

  def show
  end

  def index
    @beans = Bean.all

    puts @beans.inspect

    if params[:brewing_method].present?
      @beans = @beans.where(brewing_method: params[:brewing_method])
    end
    if params[:roast_level].present?
      @beans = @beans.where(roast_level: params[:roast_level])
    end
    if params[:origin].present?
      @beans = @beans.where(origin: params[:origin])
    end
    if params[:flavour].present?
      @beans = @beans.where(flavour: params[:flavour])
    end
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

  def destroy
    if @bean.destroy
      redirect_to request.referer&.include?(profile_path) ? profile_path : beans_path,
                  notice: "Bean successfully deleted."
    else
      redirect_to roasteries_path, alert: "Failed to delete the Bean."
    end
  end

  private

  def bean_params
    params.require(:bean).permit(:name, :description, :roast_level, :origin, :flavour, :brewing_method, :roastery_id, :main_photo, photos:[])
  end

  def set_bean
    @bean = Bean.find(params[:id])
  end

  def authorize_user
    unless user_authorized_to_delete?(@bean)
      redirect_to bean_path, alert: "You are not authorized to delete this Bean."
    end
  end

end
