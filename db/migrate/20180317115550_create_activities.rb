class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.string :author
      t.boolean :enabled, default: false
      t.text :desc
      t.text :consts
      t.text :template, null: false
      t.integer :idx, null: false

      t.timestamps null: false

      t.index :idx
    end
  end
end
