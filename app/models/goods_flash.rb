class GoodsFlash < ActiveRecord::Base

  belongs_to :goods
  belongs_to :order

  def flash_key
    "goods_flash:#{self.id}"
  end

  def self.create_flash(goods, order)
    flash = GoodsFlash.create goods_id: goods.id, order_id: order.id, price: order.price
    flash.save!
    pre_content = {
        goods: goods.flash,
        order: order.flash
    }
    $ssdb.set(flash.flash_key, pre_content.to_json)
  end
end