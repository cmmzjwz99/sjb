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
        post 'recover_password'
        get 'recover_password'
        get "freeze/:id",action:"freeze",id:/\d{1,}/,as: :freeze
      end
    end
    resources :user_areas
    resources :loans do
      collection do
        post  'update_pay_status'
        get   'overdue'
        post 'review'
        get 'totle_loan'
        get   "instalment/:id",action:"instalment",id:/\d{1,}/,as: :instalment
        get "financial/:id",action:"financial_verify",id:/\d{1,}/,as: :financial_verify
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
        get 'review'
        get 'financial'
        get "first/:id",action:"first_verify",id:/\d{1,}/,as: :first_verify
        post "first_verify"
        get "review/:id",action:"review_verify",id:/\d{1,}/,as: :review_verify
        post "review_verify"
        get "financial/:id",action:"financial_verify",id:/\d{1,}/,as: :financial_verify
        post "financial_verify"
      end
    end
    resources :loan_images do
      collection do
        post 'uploadimg'
      end
    end
    resources :bills do
      collection do
        get 'not_pay'
        get "pay/:id",action:"pay",id:/\d{1,}/,as: :pay
        get 'has_pay'
        get "instalment/:id",action:"instalment",id:/\d{1,}/,as: :instalment
        get "repay/:id",action:"repay",id:/\d{1,}/,as: :repay
        get 'has_pay_financial'
        get 'salesman_report'
        get 'performance_report'
        post 'performance_report'
      end
    end
    resources :repay_logs
    resources :products
    resources :teams
    resources :members do
      collection do
        get 'get_members'
      end
    end
  end

  root "portal#index"



  match 'api/captcha' => 'easy_captcha/captcha#captcha', :via => :get
end