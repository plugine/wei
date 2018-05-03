class ChangeUserColumn < ActiveRecord::Migration
  def change
    remove_column :users, :died_at
    add_column :users, :dead_at, :datetime
  end
end
