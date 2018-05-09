class AddPayResIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :pay_res_id, :integer
  end
end
