class CategoryController < ApplicationController

  def hollywood
    @category = Category.find(params[:id])
  end

  def bollywood
    @category = Category.find(params[:id])
  end

  def action
    @category = Category.find(params[:id])
  end

  def comedy
    @category = Category.find(params[:id])
  end

  def romance
    @category = Category.find(params[:id])
  end

end
