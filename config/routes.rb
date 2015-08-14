Rails.application.routes.draw do

  root 'students#index'

  resources :students, only: [:index, :create, :show, :update, :destroy]

end
