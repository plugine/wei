module Admin

  class PublicAccountsController < BaseController
    before_action :set_account, except: [:index, :create]

    def index
      render json: {
          code: 200,
          public_accounts: @current_user.company.public_accounts.order_desc.map(&:to_api_json)
      }
    end

    def show
      render json: {code: 200, account: @account.to_api_json}
    end

    def create
      @company = current_user.company.public_accounts.new account_params
      if @company.save
        return render json: {code: 200}
      end
      render json: {code: 419, error: @company.errors.to_s}
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
      params.permit(:name, :account, :appid, :appsecret)
    end

  end
end