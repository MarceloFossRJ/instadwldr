Rails.application.routes.draw do

  get 'about/index'
  resources :searches
  get 'home/index'

  root to: 'searches#new'

  devise_for :users

end
