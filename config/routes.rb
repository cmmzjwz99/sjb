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
    resources :matches
    resources :games do
      collection do
        get "settlement/:id",action:"settlement",id:/\d{1,}/,as: :settlement;
      end
    end
    resources :odds
    resources :user_payments
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
    # resources :payments
    resources :payments do
      collection do
        get 'payments'
        post "sh_success/:id",action:"sh_success",id:/\d{1,}/,as: :sh_success;
        post "sh_fail/:id",action:"sh_fail",id:/\d{1,}/,as: :sh_fail;
      end
    end
    resources :user_payments
  end

  namespace :api do
    resources :accounts do
      collection do
        post 'login'
        post 'signup'
        get 'info'
      end
    end
    resources :payments do
      collection do
        post 'order'
        get 'get_payments'
      end
    end
    resources :quiz do
      collection do
        get 'list'
        post 'buy'
        get 'odds'
        get 'my_order'
      end
    end
  end
end
