class CreateArticleTypes < ActiveRecord::Migration
  def change
    create_table :article_types do |t|
      t.string :name
      t.string :code
      t.string :thumb

      t.integer :public_account_id

      t.timestamps null: false
    end

    add_index :article_types, :public_account_id
  end
end
