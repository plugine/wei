class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.string :author
      t.boolean :enabled, default: false
      t.text :desc
      t.text :consts
      t.text :template, null: false
      t.string :qrurl
      t.integer :public_account_id

      t.timestamps null: false

      t.index :public_account_id
    end
  end
end
