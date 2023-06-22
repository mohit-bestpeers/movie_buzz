class CategoryController < ApplicationController

  def index
    @category = Category.where(name: params[:category])
  end

end
