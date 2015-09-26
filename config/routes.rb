Rails.application.routes.draw do
  
  namespace :v1, { defaults: { format: :json } } do

    resources :players
    resources :estates
    resources :estate_types do
      member do
        get :estate_types
      end
    end

  end

end
