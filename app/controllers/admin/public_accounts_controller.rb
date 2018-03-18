module Admin

  class PublicAccountsController < BaseController
    before_action :set_account, except: [:index]

    def index
      render json: {
          code: 200,
          public_accounts: @current_user.company.public_accounts.order_desc.map(&:as_json)
      }
    end

    def update
      updated = @account.update_attributes account_params

      return render json: {code: 200, updated: updated} if updated
      render json: {
          code: 419,
          error: @account.error_message,
          bicode: 10004
      }
    end

    def destroy
      @account.delete
      render json: { code: 200 }
    end


    private

    def set_account
      @account = PublicAccount.find(params[:id])
      raise PermissionError unless @account.company_id == current_user.company_id
    end

    def account_params
      params.permit(:name, :appid, :appsecret)
    end

  end
end