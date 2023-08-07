Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "about",to: "about#index", as: "about"
  get "sign_up", to:"registrations#new", as: "signup"
  post "sign_up", to:"registrations#create"

  get "sign_in", to:"session#new", as:"signin"
  post "sign_in", to:"session#create"

  get "user_profile",to:"user_profile#index", as:"user_profile"
  put "update_password",to:"user_profile#update_password", as:"update_password"

  delete "logout", to:"session#destroy", as:"logout"
  
  get "password/reset", to: "password_reset#new", as:"reset_password"
  post "password/reset", to:"password_reset#create"
  get "password/reset/edit", to:"password_reset#edit"
  put "password/reset/edit", to:"password_reset#update"

  get "/auth/twitter/callback", to:"omniauth_callbacks#twitter"

  resources :twitter_accounts
  resources :tweets

  root  to:"main#index"
end
