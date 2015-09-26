Rails.application.routes.draw do
  
  namespace :v1, { defaults: { format: :json } } do

    resources :players, only: [:index, :create, :update, :show]
    resources :estates, only: [:index, :create, :update, :show]
    resources :game, only: :index

  end

end
