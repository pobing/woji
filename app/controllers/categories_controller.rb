# encoding:utf-8
class CategoriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :set_category ,:only=>[:edit,:update,:destroy]
 
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
  
  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:success] = "success!"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.json { render_json_ok} 
      else
        format.json { render_json_fail} 
      end
    end
  end

  private
  
  def set_category
    @category = Category.find_by_id(params[:id])
  end
end