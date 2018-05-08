class WxpubPayConfig < ActiveRecord::Base
  validates_presence_of :name, :appid, :key, :mch_id

  after_commit do
    Rails.cache.delete WxpubPayConfig.cache_key(self.name)
  end

  def self.fetch(name)
    Rails.cache.fetch(cache_key(name)) {WxpubPayConfig.find_by_name name}
  end

  def self.cache_key(name)
    "wxpub_pay_config:#{name}"
  end
end