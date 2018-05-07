class AddPaymentNoToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payment_no, :string
  end
end
