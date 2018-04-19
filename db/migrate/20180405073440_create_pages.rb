class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :code, null: false, limit: 30
      t.text   :content, null: false
      t.string :page_type, default: 'raw', limit: 10

      t.timestamps null: false

      t.integer :public_account_id
      t.integer :article_type_id
    end

    add_index :pages, :public_account_id
    add_index :pages, :article_type_id
  end
end
