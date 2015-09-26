Rails.application.routes.draw do
  
  namespace :v1, { defaults: { format: :json } } do

    resources :players
    resources :estates
    resources :estate_types
    resources :game, only: :index

  end

end
