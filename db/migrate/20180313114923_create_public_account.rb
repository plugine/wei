class CreatePublicAccount < ActiveRecord::Migration
  def change
    create_table :public_accounts do |t|
      t.string :name
      t.string :appid, null: false, limit: 50
      t.string :appsecret, null: false, limit: 80
    end

    add_index :public_accounts, :name, unique: true
  end
end
