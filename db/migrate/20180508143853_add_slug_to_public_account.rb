class AddSlugToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :slug, :string, limit: 50
  end
end
