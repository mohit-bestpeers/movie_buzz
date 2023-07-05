require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe CategoryController, type: :controller do
 

  describe "GET #index" do
    it "assigns the category variable" do
      category = Category.create(name: "Action")
      get :index, params: { category: category.name }
      expect(assigns(:category)).to eq(Category.where(name: category.name))
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end