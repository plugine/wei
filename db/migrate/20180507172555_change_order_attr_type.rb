class ChangeOrderAttrType < ActiveRecord::Migration
  def change
    change_column :orders, :operator_note, :text
  end
end
