Rails.application.routes.draw do

  resources :notes do
    get "refreshUpdatedAt"
  end

  get 'refreshSidebar', to: 'notes#refreshSidebar', as: 'refreshSidebar'
  get 'new_blank', to: 'notes#new_blank', as: 'new_blank'

  devise_for :users, :controllers => { :registrations => "my_registrations" }

  get 'pages/home'
  root to: "notes#index"

end
