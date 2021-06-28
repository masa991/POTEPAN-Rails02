Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html                                                    
  resources :users do
    member do
      get 'profile'
    end
  end

  resources :rooms do
    collection do
      get 'search'
    end
  end
  
  resources :reservations do
    collection do
      post 'confirm'
    end
  end  
end
