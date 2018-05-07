class Order < ActiveRecord::Base
  enum state: [:initialized, :paid, :canceled, :refunded, :finished]

  validates_presence_of :price

  def generate_order_no
    fail NotImplementedError
  end
end
