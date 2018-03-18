class CreateJoinTableActivityUser < ActiveRecord::Migration
  def change
    create_join_table :activities, :users do |t|
      t.integer :activity_id
      t.integer :user_id

      t.index [:activity_id, :user_id]
    end
  end
end
