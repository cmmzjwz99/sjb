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
    resources :dashboard, only: [:index] do
      collection do
        get 'get_data'

      end
    end
    resources :users do
      collection do
        post 'recover_password'
      end
    end
    resources :agents
    resources :matches do
      collection do
        post 'get_match_id'
        post 'delete_match_id'
        post 'offline_match'
      end
    end
    resources :games do
      collection do
        get "settlement/:id",action:"settlement",id:/\d{1,}/,as: :settlement;
        get 'game_order'
      end
    end
    resources :odds
    resources :fj_matches do
      collection do
        get 'add_match'
      end
    end
    resources :user_payments do
      collection do
        post 'save_setting'
      end
    end
    resources :payments do
      collection do
        get 'payments'
        post "sh_success/:id",action:"sh_success",id:/\d{1,}/,as: :sh_success;
        post "sh_fail/:id",action:"sh_fail",id:/\d{1,}/,as: :sh_fail;
      end
    end
    resources :referees
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
    resources :dashboard, only: [:index] do
      collection do
        get 'get_data'

      end
    end
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
        get 'logout'
        post 'recover_password'
      end
    end
    resources :banks do
      collection do
        get 'info'
        post 'update_bank'
      end
    end
    resources :settings do
      collection do
        get 'title'
        get 'customer'
        get 'get_referee'
      end
    end
    resources :payments do
      collection do
        post 'order'
        post 'cash_out'
        get 'get_payments'
        get 'pay_way'
        post 'tixian'
        get 'info'
        get 'history'
        post 'cancel'
        post 'rebate'
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
    resources :ssc do
      collection do
        get 'ssc'
        post 'order'
        get 'order_list'
      end
    end
  end
end
