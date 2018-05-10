class CreateGoodsFlash < ActiveRecord::Migration
  def change
    create_table :goods_flashes do |t|
      t.boolean :paid
      t.decimal :price, precision: 10, scale: 2

      t.integer :goods_id
      t.integer :order_id

      t.timestamps null: false
    end

    add_index :goods_flashes, :goods_id
    add_index :goods_flashes, :order_id
  end
end
