require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  describe "GET index" do

    it "returns upcoming movies when filter is set to 'upcoming'" do
      future_movie = FactoryBot.create(:movie, released_on: Date.tomorrow)
    
      get :index, params: { filter: "upcoming" }
    
      expect(assigns(:movies)).to eq([future_movie])
    end

    it "returns all movies when no filter is specified" do
      get :index
      expect(assigns(:movies)).to eq(Movie.all)
    end
  
    it "returns popular movies when filter is set to 'popular'" do
      high_rated_movie = FactoryBot.create(:movie, rating: 4.0)

      get :index, params: { filter: "popular" }

      expect(assigns(:movies)).to eq([high_rated_movie])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns the requested movie to @movie" do
      movie = FactoryBot.create(:movie)

      get :show, params: { id: movie.id  }

      expect(assigns(:movie)).to eq(movie)
    end
  end

  describe 'GET #new' do
    it 'assigns a new movie to @movie' do
      get :new
      expect(assigns(:movie)).to be_a_new(Movie)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

 
end

