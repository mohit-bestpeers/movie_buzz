Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'movies#index'
  get "/upcomming", to: "movies#upcomming"
  get "/popular", to: "movies#popular_movie"
  get "/hollywood/:id", to: "category#hollywood"

  resources :movies do
    resources :reviews
  end 
  
end
