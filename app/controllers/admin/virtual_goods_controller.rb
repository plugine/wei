module Admin
  class VirtualGoodsController < BaseController
    before_action :set_goods, except: [:index, :new, :create]

    def index
      @goods = VirtualGoods.all.order(created_at: :desc)
    end

    def new
      @goods = VirtualGoods.new
    end

    def create
      goods = VirtualGoods.new params[:goods].permit!

      if goods.save
        redirect_to action: :index, alert: '成功创建虚拟商品'
      else
        redirect_to :back, alert: "创建失败：#{@account.errors.to_a.join '\n'}"
      end
    end

    def show
    end

    def update
      if @goods.update_attributes params[:goods]
        redirect_to :back, alert: '更新成功'
      else
        redirect_to :back, alert: "更新失败：#{@account.errors.to_a.join '\n'}"
      end
    end

    def destroy
      @goods.destroy

      redirect_to :back
    end


    private

    def set_goods
      @goods = VirtualGoods.find(params[:id])
    end
  end
end