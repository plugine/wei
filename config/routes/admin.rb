Wei::Application.routes.draw do
  namespace :admin do
    resource :login, only: [:create]
    resources :public_accounts
    resources :dash_boards, only: [:index, :update]
    resources :activities
  end
end