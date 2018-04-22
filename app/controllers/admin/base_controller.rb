module Admin
  class BaseController < ApplicationController

    layout 'admin'
    before_action :allow_cross_domain_access
    before_action :cors_preflight_check
    after_action :cors_set_access_control_headers

    before_action :current_user

    def allow_cross_domain_access
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = '1728000'
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = '1728000'
    end

    def cors_preflight_check
      logger.info "request method: #{request.method}"
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '123', :content_type => 'text/plain'
      end
    end

    def current_user
      @current_user ||= set_current_user
    end

    def set_current_user
      if session[:user_id]
        return CropUser.find session[:user_id]
      end

      token = request.headers['Authentication']
      token ||=params[:Authentication]

      # html render result call
      respond_to do |format|
        format.html { return redirect_to admin_logins_path }
      end

      # api call response handle
      unless token
        render json: {code: 403, error: '请先登陆', bicode: 10001}
      end

      unless (user = CropUser.from_token(token))
        return render json: {code: 403, error: '登陆信息已过期', bicode: 10002}
      end
      user
    end

  end
end