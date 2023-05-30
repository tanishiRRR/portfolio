class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, success: 'カテゴリーを作成しました'
    else
      @categories = Category.all
      if @category.category_name.empty?
        flash.now[:warning] = 'カテゴリ名を入力してください'
      else
        flash.now[:warning] = '既に登録済みのカテゴリ名は入力できません'
      end
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, success: 'カテゴリーを編集しました'
    else
      if @category.category_name.empty?
        flash.now[:warning] = 'カテゴリ名を入力してください'
      else
        flash.now[:warning] = '既に登録済みのカテゴリ名は入力できません'
      end
      render :edit
    end
  end

  private

    def category_params
      params.require(:category).permit(:category_name)
    end

end