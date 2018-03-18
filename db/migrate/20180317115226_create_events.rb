class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_type, null: false
      t.string :action_type, null: false
      t.string :condition
      t.string :extra
      t.integer :priority

      t.integer :public_account_id

      t.timestamps null: false

      t.index :event_type
      t.index :public_account_id
    end
  end
end
