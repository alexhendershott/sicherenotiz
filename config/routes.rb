Rails.application.routes.draw do
  resources :notes
  devise_for :users

  get 'pages/home'
  root to: "notes#show"

  get 'note/:id/show_dynamic', to: 'notes#show_dynamic', as: 'show_dynamic'
end
