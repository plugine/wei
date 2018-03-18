class CreateCropUsers < ActiveRecord::Migration
  def change
    create_table :crop_users do |t|
      t.string :account, null: false
      t.string :password_digest, null: false
      t.string :phone, null: false

      t.integer :company_id
      t.timestamps
    end

    add_index :crop_users, :account
  end
end
