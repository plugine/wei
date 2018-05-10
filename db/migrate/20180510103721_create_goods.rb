class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :title, limit: 191
      t.string :slug, limit: 40
      t.integer :state, default: 0
      t.decimal :market_price, precision: 10, scale: 2
      t.decimal :price, precision:10, scale: 2
      t.string :cover_img, limit: 255
      t.string :unit_name, limit: 20
      t.integer :sale_count, default: 0
      t.string :pics, limit: 800
      t.text :content_html

      t.timestamps
    end

    add_index :goods, :title
    add_index :goods, :slug
    add_index :goods, :state
    add_index :goods, :price
  end
end
