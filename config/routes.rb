UscisWeb::Application.routes.draw do

  resources :applications

  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_up", :to => "devise/registrations#new"
    get "sign_out", :to => "devise/sessions#destroy", via: :delete
  end

  root :to => 'home#index'

  get 'dashboard', to: "applications#index"

end
