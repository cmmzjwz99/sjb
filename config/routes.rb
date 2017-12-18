Rails.application.routes.draw do

  # captcha_route

  namespace :admin do
    # sidekiq monitor

    # root
    root "dashboard#index"
    # resources :admins, path: '/'
    resources :resources
    resources :baofoo
    resources :accounts, only: [:index], format: false do
      collection do
        get 'login'
        post 'login'
        get 'signup'
        post 'signup'
        get 'logout'
      end
    end
    resources :dashboard, only: [:index]
    resources :advs
    resources :users
    resources :loans do
      collection do
        post  'update_pay_status'
        get   "online_pay/:id",action:"online_pay",id:/\d{1,}/,as: :online_pay
        get   "service/:id",action:"service",id:/\d{1,}/,as: :service
        get   'overdue'
      end
    end
    resources :repay_logs do
      collection do
        post 'cancel'
      end
    end
    resources :user_contacts, only: [:index]
    resources :continuous_loans, only: [:index]
    resources :instalments do
      collection do
        get 'overdue'
        get 'detail'
      end
    end
    resources :contracts
    resources :modifypassword do
      collection do
        get 'modify'
      end
    end
    resources :verify  do
      collection do
        get 'first'
        get 'customer'
        get 'car'
        get "first/:id",action:"first_verify",id:/\d{1,}/,as: :first_verify
      end
    end
  end

  root "portal#index"



  match 'api/captcha' => 'easy_captcha/captcha#captcha', :via => :get
end