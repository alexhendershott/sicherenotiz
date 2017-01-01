Rails.application.routes.draw do

  resources :notes do
    get "refreshUpdatedAt"
  end

  get 'refreshSidebar', to: 'notes#refreshSidebar', as: 'refreshSidebar'

  devise_for :users

  get 'pages/home'
  root to: "notes#index"

end
