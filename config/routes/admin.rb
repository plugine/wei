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
      get :refresh_qr, on: :collection
    end

    resources :buttons
  end
end