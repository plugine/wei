class CreateMediaResources < ActiveRecord::Migration
  def change
    create_table :media_resources do |t|
      t.string :name
      t.string :qiniu_key

      t.timestamps null: false

      t.integer :public_account_id
    end

    add_index :media_resources, :public_account_id
  end
end
