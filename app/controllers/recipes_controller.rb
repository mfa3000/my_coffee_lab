class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bean
  before_action :set_recipe, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @recipe = @bean.recipes.new
  end

  def create
    @recipe = @bean.recipes.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to bean_path(@bean), notice: "Recipe added successfully!"
    else
      flash.now[:alert] = @recipe.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to bean_path(@bean), notice: "Recipe updated successfully!"
    else
      flash.now[:alert] = @recipe.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to bean_path(@bean), notice: "Recipe deleted successfully!"
  end

  private

  def set_bean
    @bean = Bean.find(params[:bean_id])
  end

  def set_recipe
    @recipe = @bean.recipes.find(params[:id])
  end

  def authorize_user!
    unless @recipe.user == current_user
      redirect_to bean_path(@bean), alert: "You are not authorized to perform this action."
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :instructions)
  end
end
