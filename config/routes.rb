require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'haelo' && password == 'haelo'
end if Rails.env.production?

Wei::Application.routes.draw do

  get '/admin' => 'admin/logins#index'
  resource :wechat, only: [:show, :create]
  mount Sidekiq::Web => '/admin/sidekiq'

  resources :pages, only: [:show], param: :code
  resources :storages, param: :key
  resources :types, only: [:show], param: :code
end
