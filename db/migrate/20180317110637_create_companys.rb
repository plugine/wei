class CreateCompanys < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.date :expire_at, default: Date.today + 1.year
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
