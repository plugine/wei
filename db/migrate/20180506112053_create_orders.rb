class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_no, null: false, limit: 255
      t.decimal :price, precision: 8, scale: 2
      t.string :type
      t.string :real_name
      t.string :phone
      t.integer :state
      t.string :address, limit: 512
      t.datetime :paid_at
      t.decimal :carriage, precision: 10, scale: 2, default: 0.0
      t.string :note, limit: 512
      t.string :operator_note, limit: 512


      t.timestamps

      t.integer :user_id
      t.integer :crop_user_id
    end

    add_index :orders, :order_no
    add_index :orders, :phone
    add_index :orders, [:type, :state]
  end
end
