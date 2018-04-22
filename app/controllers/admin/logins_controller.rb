module Admin
  class LoginsController < BaseController
    skip_before_action :current_user
    layout false

    def index
    end

    def create
      user = CropUser.find_by_account(params[:account])

      unless user&.authenticate(params[:password])
        respond_to do |format|
          format.html { return redirect_to admin_logins_path, alert: '用户名或密码错误' }
          format.json { return render json: {code: 401, error: '用户名或密码错误', bicode: 10003} }
        end
      end

      respond_to do |format|
        format.html do
          session[:user_id] = user.id
          redirect_to admin_dash_boards_path
        end
        format.json { render json: {code: 200, user: user.as_json, company: user.company.as_json, authentication: user.token} }
      end
    end
  end
end