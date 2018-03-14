module Admin
  class LoginsController < BaseController
    skip_before_action :current_user, only: [:create]

    def create
      user = User::AdminUser.find_by(account: params[:account])
      unless user&.authenticate(params[:password])
        return render json: {code: 401, error: '用户名或密码错误', bicode: 10003}
      end
      render json: {code: 200, user: user.as_api_json, authentication: user.token}
    end

  end
end