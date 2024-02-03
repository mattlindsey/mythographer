Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  resources :gods
  resources :stories do
    resources :story_gods # , shallow: true
    # TODO:
    # https://dev.to/pezza/dynamic-nested-forms-with-turbo-3786
  end
  # Defines the root path route ("/")
  root "mythologies#index"
end
