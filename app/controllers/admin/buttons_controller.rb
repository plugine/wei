module Admin
  class ButtonsController < BaseController
    before_action :set_account


    def index
      @button = @account.account_button
      if @button
        render json: {code: 200, button_json: @button.button_json}
      else
        render json: {code: 404, error: '公众号还没有菜单'}
      end
    end

    def create
      @button = @account.account_button
      if @button
        @button.update button_json: params[:button_json]
      else
        @button = @account.create_account_button params[:button_json]
      end
      msg = @button.update_account_button
      render json: {code: 200, msg: msg}
    end

    private
    def set_account
      @account = PublicAccount.find(params[:public_account_id])
    end
  end
end