Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
 end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :foods, except: [:update, :edit]

  resources :recipes, except: [:edit] do
    resources :recipe_foods, only: [:new, :create, :destroy]
    member do
      patch 'toggle_public', to: 'recipes#toggle_public' # Route for toggling recipe public/private status
    end
  end

  get '/public_recipes', to: 'recipes#public_recipes'

  get '/general_shopping_list', to: "recipe_foods#general_shopping_list"

  # Defines the root path route ("/")
  root "foods#index"
end
