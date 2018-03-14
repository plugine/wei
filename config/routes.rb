require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'sidekiq' && password == 'sidekiq'
end if Rails.env.production?


Wei::Application.routes.draw do

  mount Sidekiq::Web => '/admin/sidekiq'

end
