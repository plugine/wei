class Goods < ActiveRecord::Base
  # initial:   "未发布"
  # on_sale:   "已上架"
  # not_sale:  "补货中"
  # stop_sale: "已售罄下架"
  enum state: [:initial, :on_sale, :not_sale, :stop_sale]

  has_many :goods_flashes

  alias_method :flash, :as_json
end