Wei::Application.routes.draw do
  namespace :admin do
    resources :logins, only: [:index, :create]

    resources :panels, only: [:index]
    resources :public_accounts
    resources :dash_boards, only: [:index, :update]

    resources :activities

    resources :buttons
  end
end