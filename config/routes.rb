Rails.application.routes.draw do
  
  namespace :v1, { defaults: { format: :json } } do

    resources :players, except: [:new, :edit] do
      patch :attack
      member do
        patch :refuse_challenge
      end
    end
    resources :estates, except: [:new, :edit] do
      member do
        get :estate_types
      end
    end
    resources :estate_types, except: [:new, :edit]
    resources :gangs, except: [:new, :edit]

  end

end
