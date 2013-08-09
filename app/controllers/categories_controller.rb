# encoding:utf-8
class CategoriesController < ApplicationController
  def show
    name = CGI::unescapeHTML(params[:id])
    @category = Category.find_by_name(name)
    @posts = @category.posts
  end
end