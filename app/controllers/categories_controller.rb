class CategoriesController < ApplicationController
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'カテゴリーを作成しました'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = 'カテゴリーを更新しました。'
      redirect_to category_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id]).destroy
    flash[:success] = 'カテゴリーを削除しました。'
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
