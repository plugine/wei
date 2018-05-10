class GoodsOrder < Order
  def generate_order_no
    "GD#{SecureRandom.hex(8)}"
  end
end