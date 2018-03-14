module Admin
  class BaseController < ApplicationController

    def current_user
      token = request.headers['Authentication']
      unless token
        render json: {code: 403, error: '请先登陆', bicode: 10001}
      end

      unless (@current_user = AdminUser.from_token(token))
        render json: {code: 403, error: '登陆信息已过期', bicode: 10002}
      end
    end

  end
end