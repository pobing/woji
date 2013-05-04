# encoding:utf-8
class CategoriesController < ApplicationController
  # before_filter :logined 
  layout 'manage'
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "success!"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  def show
    @category = Category.find(params[:id])
  end
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_url
    end
  end
end