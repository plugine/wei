require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'haelo' && password == 'haelo'
end if Rails.env.production?

Wei::Application.routes.draw do

  get '/admin' => 'admin/logins#index'

  get '/wechat/auth/:storage_name' => 'wechats#auth'

  resource :wechat, only: [:show, :create] do
    get :wx_config, on: :collection
  end
  mount Sidekiq::Web => '/admin/sidekiq'

  resources :pages, only: [:show], param: :code
  resources :storages, param: :key, only: [:show, :create] do
    post :append, on: :collection
  end
  resources :types, only: [:show], param: :code
  resources :orders, onlt: [:show, :create]

  resources :payments, only: [:create] do
    post :wx_notify, on: :collection
  end

  resource :delivery_infos, only: [:create]
end
