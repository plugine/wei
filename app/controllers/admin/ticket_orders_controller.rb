module Admin
  class TicketOrdersController < BaseController
    before_action :set_order, except: [:index, :new, :create]

    def index
      @orders = TicketOrder.all.order(id: :desc)
    end

    def show
      redirect_to "/pages/ticket?oid=#{@order.order_no}"
    end

    def new
      @order = TicketOrder.new
    end

    def create
      @order = TicketOrder.new(params[:ticket_order].permit!)

      if @order.save
        redirect_to action: :index, alert: '创建成功'
      else
        redirect_to :back, alert: "创建失败: #{@order.errors.to_a.join '\n'}"
      end
    end

    def update
      if @order.update_attributes params[:ticket_order].permit!
        redirect_to :back, alert: '修改成功'
      else
        redirect_to :back, alert: "创建失败: #{@order.errors.to_a.join '\n'}"
      end
    end

    def destroy
      @order.destroy

      redirect_to :back
    end

    private

    def set_order
      @order = TicketOrder.find(params[:id])
    end
  end
end