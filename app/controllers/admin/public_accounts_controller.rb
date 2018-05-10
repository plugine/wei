module Admin

  class PublicAccountsController < BaseController
    before_action :set_account, except: [:index, :create, :new]

    def index
      @accounts = @current_user.company.public_accounts.order_desc

      respond_to do |format|
        format.json {render json: {code: 200, public_accounts: @accounts.map(&:to_api_json) } }
        format.html
      end
    end

    def edit
    end

    def new
      @account = PublicAccount.new
    end

    def show
      respond_to do |format|
        format.json { render json: {code: 200, account: @account.to_api_json} }
        format.html
      end
    end

    def create
      @account = current_user.company.public_accounts.new account_params

      respond_to do |format|
        if @account.save
          format.json { render json: {code: 200} }
          format.html { redirect_to admin_public_accounts_path, alert: '创建成功' }
        else
          errors = @account.errors.to_a.join '\n'
          format.json { render json: {code: 419, error: errors} }
          format.html { redirect_to :back, alert: errors }
        end
      end
    end

    def update
      updated = @account.update_attributes account_params
      logger.info "result: #{@account.update_account_button}"

      respond_to do |format|
        if updated
          format.json { render json: {code: 200} }
          format.html { redirect_to :back, alert: '更新成功' }
        else
          errors = @account.errors.to_a.join "\n"
          format.json { render json: {code: 419, error: errors} }
          format.html { redirect_to :back, alert: errors }
        end
      end

    end

    def destroy
      @account.destroy

      respond_to do |format|
        format.json { render json: {code: 200}}
        format.html { redirect_to admin_public_accounts_path }
      end
    end

    private

    def set_account
      @account = PublicAccount.find(params[:id])
      raise PermissionError unless @account.company_id == current_user.company_id
    end

    def account_params
      params.require(:public_account).permit(:name, :account, :appid, :appsecret, :menu_json, :slug)
    end

  end
end