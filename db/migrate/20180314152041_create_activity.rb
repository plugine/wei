class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, unique: true
      t.string :author
      t.text :code_template
      t.text :constants
      t.timestamps

      t.index :name
    end
  end
end
