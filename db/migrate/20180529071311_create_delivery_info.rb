class CreateDeliveryInfo < ActiveRecord::Migration
  def change
    create_table :delivery_infos do |t|
      t.string :province
      t.string :city
      t.string :street
      t.string :name
      t.string :phone

      t.integer :user_id

      # this could be order id
      t.integer :resource_id
      t.integer :activity_id
      t.string :comment
    end

    add_index :delivery_infos, :activity_id
    add_index :delivery_infos, :user_id
    add_index :delivery_infos, :name
  end
end
