class CreateUserAdminUser < ActiveRecord::Migration
  def change
    create_table :user_admin_users do |t|
      t.string :account, null: false, limit: 50
      t.string :password_digest, null: false, limit: 100
    end
  end
end
