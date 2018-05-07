class AddTitleToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :title, :string, limit: 191
  end
end
