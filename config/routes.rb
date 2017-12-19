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
    resources :dashboard, only: [:index] do
      collection do
        get 'power'
      end
    end
    resources :advs
    resources :users do
      collection do
        post 'update_area'
        post 'update_power'
      end
    end
    resources :loans do
      collection do
        post  'update_pay_status'
        get   "online_pay/:id",action:"online_pay",id:/\d{1,}/,as: :online_pay
        get   "service/:id",action:"service",id:/\d{1,}/,as: :service
        get   'overdue'
        post 'car'
        post 'customer'
        post 'basic'
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
        get 'basic'
        get 'customer'
        get 'car'
        get "first/:id",action:"first_verify",id:/\d{1,}/,as: :first_verify
        post "first_verify"
        get "basic/:id",action:"basic_verify",id:/\d{1,}/,as: :basic_verify
        post "basic_verify"
        get "car/:id",action:"car_verify",id:/\d{1,}/,as: :car_verify
        post "car_verify"
        get "customer/:id",action:"customer_verify",id:/\d{1,}/,as: :customer_verify
        post "customer_verify"
      end
    end
    resources :car_messages
    resources :customer_messages do
      collection do
        post 'img_upload'
      end
    end
    resources :loan_images, only: [:destroy] do
      collection do
        post 'uploadimg'
        get 'uploadimg'
      end
    end
    resources :customer_images
    resources :bills do
      collection do
        get 'not_pay'
        get "pay/:id",action:"pay",id:/\d{1,}/,as: :pay
      end
    end
  end

  root "portal#index"



  match 'api/captcha' => 'easy_captcha/captcha#captcha', :via => :get
end