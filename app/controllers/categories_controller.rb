class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    category
    authorize @category
  end

  def create
    @category = Category.create(category_params)
    authorize @category
      return redirect_to categories_url, notice: t(".created") if @category.save

      render :new, status: :unprocessable_entity
  end


  def update
    category
    authorize @category
      return redirect_to categories_url, notice: t(".updated") if @category.update(category_params)

      render :edit, status: :unprocessable_entity
  end


  def destroy
    category
    authorize @category
    @category.destroy

    redirect_to categories_url, notice: t(".destroyed")

  end

  private
  def category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
