Wei::Application.routes.draw do
  namespace :admin do
    resources :logins, only: [:index, :create]

    resources :panels, only: [:index]
    resources :public_accounts
    resources :dash_boards, only: [:index, :update]

    resources :pages do
      get :account_pages, on: :collection
    end

    resources :activities do
      get :refresh_qr, on: :member
    end

    resources :users

    resources :ticket_orders
    
    resources :buttons

    resource :crop_users

    resources :pay_configs do
      collection do
        get :wechat_list
      end
    end

    resources :virtual_goods
  end
end