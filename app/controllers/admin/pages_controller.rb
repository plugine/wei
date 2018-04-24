class Admin::PagesController < Admin::BaseController
  before_action :set_account, only: [:create, :new, :edit, :update, :destroy]

  def index
    @accounts = current_user.company.public_accounts
  end

  def account_pages
    @pages = current_user.company.public_accounts.find(params[:public_account_id]).pages
  end

  def create
    page = @account.pages.new page_params
    if page.save
      redirect_to :back, alert: '创建成功'
    else
      redirect_to :back, alert: "创建失败： #{page.errors.to_a.map(&:to_s).join("\n")}"
    end
  end

  def new
    @account = current_user.company.public_accounts.find(params[:public_account_id])
    @page = @account.pages.new
  end

  def edit
    @page = @account.pages.find(params[:id])
  end

  def update
    @page = @account.pages.find(params[:id])
    if @page.update page_params
      redirect_to :back, alert: '更新成功'
    else
      redirect_to :back, alert: "更新失败： #{@page.errors.to_a.map(&:to_s).join("\n")}"
    end
  end

  def destroy
    @page = @account.pages.find(params[:id])
    @page.destroy
    redirect_to :back, alert: '删除成功'
  end

  private
  def set_account
    @account = current_user.company.public_accounts.find(params[:public_account_id])
  end

  def page_params
    params.require(:page).permit!
  end
end