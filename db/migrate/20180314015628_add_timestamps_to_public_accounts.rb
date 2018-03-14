class AddTimestampsToPublicAccounts < ActiveRecord::Migration
  def change
    add_timestamps :public_accounts
  end
end
