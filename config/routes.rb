Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :payments, only: %i[create]

    resources :blogs, except: %i[new edit]
    
  end
end
