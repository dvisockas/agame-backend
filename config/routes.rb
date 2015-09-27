Rails.application.routes.draw do
  
  namespace :v1, { defaults: { format: :json } } do

    resources :players, except: [:new, :edit] do
      member do
        patch :attack
        patch :join_gang
      end
    end
    resources :estates, except: [:new, :edit] do
      member do
        get :estate_types
      end
    end
    resources :estate_types, except: [:new, :edit]

  end

end
