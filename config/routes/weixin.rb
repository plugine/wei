Wei::Application.routes.draw do
  namespace :weixin do
    resource :weixin, only: [:index, :create]
  end
end