class AddMenuToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :menu_json, :text
  end
end
