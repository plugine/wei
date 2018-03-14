Wei::Application.routes.draw do
  namespace :admin do
    resource :login, only: [:create]
    resources :public_accounts
  end
end