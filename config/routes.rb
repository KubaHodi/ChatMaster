Rails.application.routes.draw do
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
  resources :users

  controller :rooms do
    get "/rooms", to: "rooms#index"
  end

  resources :rooms do
    resources :messages, only: [:create]
  end
  resources :users, only: [ :show ]
  get "search", to: "search#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
