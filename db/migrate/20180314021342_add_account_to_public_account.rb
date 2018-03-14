class AddAccountToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :account, :string
  end
end
