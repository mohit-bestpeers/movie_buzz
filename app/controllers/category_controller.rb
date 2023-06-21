class CategoryController < ApplicationController

  def hollywood
    @category = Category.find(params[:id])
  end

  def bollywood
    @category = Category.find(params[:id])
  end

end
