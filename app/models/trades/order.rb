class Order < ActiveRecord::Base
  enum state: [:initialized, :paid, :canceled, :refunded, :finished]

  has_many :payments

  # 订单商品快照
  has_many :goods_flashes

  def generate_new(params)
    clazz = case params.delete(:order_type)
              when :virtual
                GoodsOrder
              else
                Order
            end
    clazz.new params
  end

  before_create do
    self.order_no = generate_order_no
    self.state = Order.states[:initialized]
  end

  validates_presence_of :price

  def generate_order_no
    fail NotImplementedError
  end

  def state_text
    {
        initialized: '未支付',
        paid: '已支付',
        canceled: '已取消',
        refunded: '已退款',
        finished: '已完成'
    }[self.state.to_s.to_sym]
  end
end
