require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe MoviesController, type: :controller do
 

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  describe "GET index" do

    it "returns upcoming movies when filter is set to 'upcoming'" do
      future_movie = FactoryBot.create(:movie, released_on: Date.tomorrow)

      get :index, params: { filter: "upcomming" }
      
      expect(assigns(:movies)).to match_array([future_movie])
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



  describe "GET create" do 
    let(:user) { User.create(email: 'test@example.com', password: 'password',role: "admin") }
    let(:category) { Category.create(name: 'hollywood') }
    let(:movie_params) { { name: 'Test Movie', rating: 3, description: 'fdsgrdsgr', released_on: '2023-07-04', director: 'kuldddp', user_id: user.id, category_id: category.id } }
    let(:movie_param) { { name: 'Test Movie', rating: 3, description: 'fdsgrdsgr', released_on: '2023-07-04', director: 'kuldddp', user_id: user.id} }
    it 'creates a new movie' do
      sign_in user

      expect {
        post :create, params: { movie: movie_params }
        }.to change { Movie.count }.by(1)
    end
   
    it 'renders a new movie ' do
      sign_in user

      expect {
        post :create, params: { movie: movie_param }
        }.to change { Movie.count }.by(0)

        expect(response).to render_template(:new)
    end
  end
  

    describe 'GET #edit' do
    let(:user) { User.create(email: 'test@example.com', password: 'password',role: "admin") }
    let(:category) { Category.create(name: 'hollywood') }
    it 'assigns the correct movie to @movie' do
        sign_in user

        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
       
        get :edit, params: { id: movie.id}
        
        expect(assigns(:movie)).to eq(movie)
      end
  
      it 'renders the edit template' do
        sign_in user
        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
        
        get :edit, params: { id: movie.id }
        
        expect(response).to render_template(:edit)
      end
    end

    
    describe 'PATCH #update' do
    let(:user) { User.create(email: 'test@example.com', password: 'password',role: "admin") }
    let(:category) { Category.create(name: 'hollywood') }
    
    before do
      sign_in(user) 
    end
    
    context 'when update is successful' do
      it 'updates the movie attributes' do
        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
        patch :update, params: { id: movie.id, movie: { name: 'Updated Movie Name' } }
        movie.reload
        expect(movie.name).to eq('Updated Movie Name')
      end
  
      it 'redirects to the updated movie' do
        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
        patch :update, params: { id: movie.id, movie: { name: 'Updated Movie Name' } }
        expect(response).to redirect_to(movie)
      end
      
      it 'sets a success notice' do
        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
        patch :update, params: { id: movie.id, movie: { name: 'Updated Movie Name' } }
        expect(flash[:notice]).to eq('Successfully Updated your Movie Name!')
      end
    end
    
    it 'renders edit template with unprocessable entity status and error alert' do
      sign_in user
        movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
        
        get :update, params: { id: movie.id ,movie: { name: ' ' }}
        
        expect(response).to render_template(:edit)
    end
  end




    describe 'DELETE #destroy' do
    let(:user) { User.create(email: 'test@example.com', password: 'password',role: "admin") }
    let(:category) { Category.create(name: 'hollywood') }
    before do
      sign_in(user) 
    end
    
    it 'destroys the movie' do
      movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
      expect {
        delete :destroy, params: { id: movie.id }
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to the root path' do
      movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
      delete :destroy, params: { id: movie.id }
      expect(response).to redirect_to(root_path)
    end

    it 'sets a success notice' do
      movie = FactoryBot.create(:movie, user_id: user.id, category_id: category.id)
      delete :destroy, params: { id: movie.id }
      expect(flash[:notice]).to eq('Successfully Deleted Movie!')
    end
  end


  describe "GET about" do
    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end
  
  describe "before_action authenticate_user!" do
    controller do
      before_action :authenticate_user!, only: [:create, :edit, :destroy, :update]
      
      def index
        render plain: "Index"
      end
    end
    
    it "allows access to index action when not authenticated" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "redirects to sign-in when not authenticated" do
      get :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  

  describe "POST search" do
    it "assigns search results to @search" do
      movie1 = FactoryBot.create(:movie, name: "Test Movie 1", description: "Description 1")
      movie2 = FactoryBot.create(:movie, name: "Test Movie 2", description: "Description 2")
      
      post :search, params: { search: "test" }
      
      expect(assigns(:search)).to eq([movie1, movie2])
    end
    
    it "renders the search view when search results are found" do
      FactoryBot.create(:movie, name: "Test Movie", description: "Description")
      
      post :search, params: { search: "test" }
      
      expect(response).to render_template("search")
    end
    
    it "renders the search view when no search results are found" do
      post :search, params: { search: "test" }
      
      expect(response).to render_template("search")
    end
  end



  describe 'POST #create' do
    it 'permits the correct movie parameters' do
      movie_attributes = {
        name: 'Example Movie',
        rating: 'PG-13',
        description: 'An exciting movie',
        director: 'John Doe',
        released_on: '2022-01-01',
        category_id: 1,
        image: 'example.jpg'
      }

      post :create, params: { movie: movie_attributes }

      permitted_params.each do |param|
        expect(controller.params[:movie]).to include(param)
      end
    end

    def permitted_params
      %i[name rating description director released_on category_id image]
    end
  end
  
end

