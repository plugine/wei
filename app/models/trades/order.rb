class Order < ActiveRecord::Base
  enum state: [:initialized, :paid, :canceled, :refunded, :finished]

  has_many :payments

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
