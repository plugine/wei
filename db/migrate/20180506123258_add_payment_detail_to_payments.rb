class AddPaymentDetailToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :pay_data, :string, limit: 512
    add_column :payments, :pay_detail, :text
  end
end
