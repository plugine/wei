class CreateReminds < ActiveRecord::Migration
  def change
    create_table :reminds do |t|
      t.string :title, limit: 255
      t.string :category, limit: 100, default: '默认'
      t.integer :state, default: 0
      t.integer :priority, default: 0
      t.text :content
      t.datetime :remind_at, null: false

      t.timestamps
      t.integer :connection_resource_id
    end

    add_index :reminds, :remind_at
    add_index :reminds, :connection_resource_id
  end
end
