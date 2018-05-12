Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    # root
    root "dashboard#index"
    # resources :admins, path: '/'
    resources :accounts, only: [:index], format: false do
      collection do
        get 'login'
        post 'login'
        get 'recover_password'
        post 'recover_password'
        get 'logout'
      end
    end
    resources :dashboard, only: [:index]
  end
end
