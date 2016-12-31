Rails.application.routes.draw do

  resources :notes do
    get "lastupdated"
  end

  devise_for :users

  get 'pages/home'
  root to: "notes#index"

end
