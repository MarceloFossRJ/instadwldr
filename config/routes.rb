Rails.application.routes.draw do

  resources :searches
  get 'home/index'

  root to: 'searches#new'

  devise_for :users

end
