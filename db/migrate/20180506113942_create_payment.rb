class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :total_fee, precision: 8, scale: 2
      t.string  :type
      t.integer :state

      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end
end
