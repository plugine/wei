class AddTypeToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :type, :string, limit: 255
  end
end
