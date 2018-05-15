Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    #sidekiq
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
    Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
      [user, password] == %w(admin P@ssw0rd)
    end

    # root
    root 'dashboard#index'
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
    resources :users
    resources :agents
    resources :matchs
  end

  namespace :agent do
    root "dashboard#index"
    resources :accounts, only: [:index], format: false do
      collection do
        get 'login'
        post 'login'
        get 'logout'
      end
    end
    resources :dashboard, only: [:index]
    resources :users do
      collection do
        get 'recover_password'
        post 'recover_password'
      end
    end
    resources :agents
    resources :payments
  end

  namespace :api do
    resources :quiz do
      collection do
        get 'list'
      end
    end
  end
end
