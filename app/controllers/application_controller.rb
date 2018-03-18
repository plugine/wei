class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  class Admin::PermissionError < StandardError; end

  rescue_from Admin::PermissionError do
    render json: {code: 401, error: '你无权进行这个操作', bicode: 10004}
  end
end
