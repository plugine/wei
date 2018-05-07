module Admin
  class PayConfigsController < BaseController
    before_action :set_class, except: [:index, :wechat_list]

    def index
      redirect_to action: :wechat_list
    end

    def wechat_list
      @cfgs = WxpubPayConfig.all.order(created_at: :desc)
    end

    def new
      @cfg = @clazz.new

      render "new_#{params[:type].underscore}"
    end

    def show
    end

    def create
      @cfg = @clazz.new params[params[:type].underscore].permit!
      if @cfg.save
        redirect_to :back, alert: '创建成功'
      else
        errors = @cfg.errors.to_a.join '\n'
        redirect_to :back, alert: "保存失败：#{errors}"
      end
    end

    def edit
      @cfg = @clazz.find(params[:id])

      render "edit_#{params[:type].underscore}"
    end

    def update
      @cfg = @clazz.find(params[:id])
      @cfg.update_attributes params[params[:type].underscore].permit!

      redirect_to :back, alert: '更新成功'
    end

    def destroy
      @cfg = @clazz.find(params[:id])
      @cfg.destroy

      redirect_to :back
    end

    private

    def set_class
      @clazz = params[:type].constantize
    end
  end
end