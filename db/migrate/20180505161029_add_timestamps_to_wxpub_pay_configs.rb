class AddTimestampsToWxpubPayConfigs < ActiveRecord::Migration
  def change
    add_timestamps :wxpub_pay_configs
  end
end
