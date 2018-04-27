class ChangeUserNicknameLimit < ActiveRecord::Migration
  def change
    change_column :users, :nickname, :string, limit: 191
  end
end
