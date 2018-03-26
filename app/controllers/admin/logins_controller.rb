module Admin
  class LoginsController < BaseController
    skip_before_action :current_user, only: [:create]

    def create
      user = CropUser.find_by_account(params[:account])
      logger.info "user account: #{user&.account}, password: #{params[:password]}"
      unless user&.authenticate(params[:password])
        return render json: {code: 401, error: '用户名或密码错误', bicode: 10003}
      end
      render json: {code: 200, user: user.as_json, company: user.company.as_json, authentication: user.token}
    end

  end
end