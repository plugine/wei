module Admin
  class LoginController < BaseController
    skip_before_action :current_user, only: [:create]

    def create
      user = AdminUser.find_by(account: params[:account])
      unless user&.authenticate(params[:password])
        return render json: {code: 401, error: '用户名或密码错误'}
      end
      render json: {code: 200, user: user.as_api_json}
    end

    private

    def login_params
      params.permit(:account, :password)
    end
  end
end