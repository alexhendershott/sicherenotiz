Rails.application.routes.draw do
  resources :notes
  devise_for :users

  get 'pages/home'
  root to: "notes#index"

end
