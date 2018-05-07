class WxpubPayConfig < ActiveRecord::Base
  validates_presence_of :name, :appid, :key, :mch_id

  def self.fetch(name)
    Rails.cache.fetch(cache_key(name)) {WxpubPayConfig.find_by_name name}
  end

  def cache_key(name)
    "wxpub_pay_config:#{name}"
  end
end