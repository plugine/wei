class CreateWxpubPayConfig < ActiveRecord::Migration
  def change
    create_table :wxpub_pay_configs do |t|
      t.string :name, null: false
      t.string :appid, null: false
      t.string :key, null: false
      t.string :mch_id, null: false
    end
  end
end
