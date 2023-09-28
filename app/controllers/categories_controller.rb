class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    find_category
  end

  def create
    @category = Category.create(category_params)
      return redirect_to categories_url, notice: t(".created") if @category.save

      render :new, status: :unprocessable_entity
  end


  def update
    find_category

      return format.html { redirect_to categories_url, notice: t(".updated") } if @category.update(category_params)

      render :edit, status: :unprocessable_entity
  end


  def destroy
    find_category
    @category.destroy

    redirect_to categories_url, notice: t(".destroyed")

  end

  private
  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
