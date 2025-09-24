Rails.application.routes.draw do
  get "secure_info/index"
  post "secure_info/index"
  get "secure_info/show"
  get "memberships/new"
  get "memberships/show"
  get "memberships/create"
  get "memberships/delete"
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "search/index"
  root "home#index"

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
  controller :users do
    get "register" => :new
    post "register" => :create
    get "/users", to: "users#index"
  end
  resources :users do
    get :friends, on: :collection
    get 'membership' => :show, to: "memberships#show", as: "show_membership"
    resources :memberships, only: [:show, :update] do
      member do
        patch :block
        patch :unblock
      end
  end

  controller :invitations do
    get "invite" => :new
    post "invite" => :create

    get "invitations" => :index
    get '/invitations/:token', to: 'invitations#show', as: "accept_invitation"
    delete '/invitations/:token', to: 'invitations#destroy', as: "destroy_invitation"
    patch '/invitations/:token', to: 'invitations#update', as: "update_invitation" 
  end
  
  resources :invitations do
    resources :memberships, only: :create
    end
  end

  controller :rooms do
    get "/rooms", to: "rooms#index"
  end

  resources :rooms do
    resources :messages, only: [:create]
  end
  resources :users, only: [ :show ]
  get "search", to: "search#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #For password reset

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
