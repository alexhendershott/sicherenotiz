Rails.application.routes.draw do
  resources :notes
  get 'pages/home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get 'note/:id/show_dynamic', to: 'notes#show_dynamic', as: 'show_dynamic'
end
