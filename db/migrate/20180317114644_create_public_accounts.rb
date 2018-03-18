class CreatePublicAccounts < ActiveRecord::Migration
  def change
    create_table :public_accounts do |t|
      t.string :name, null: false
      t.string :account, null: false
      t.string :appid, null: false
      t.string :appsecret, null: false

      t.integer :company_id

      t.timestamps
    end
  end
end
