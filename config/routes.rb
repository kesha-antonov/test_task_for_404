Rails.application.routes.draw do

  root 'students#index'

  resources :students, only: [:index, :create, :show, :update, :destroy] do
    get 'high_rated', to: 'students#high_rated', as: :high_rated, method: :json, on: :collection
    get 'high_registrated', to: 'students#high_registrated', as: :high_registrated, method: :json, on: :collection
    get 'search', to: 'students#search', as: :search, method: :json, on: :collection
  end

end
