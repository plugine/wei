class User::AdminUser < ActiveRecord::Base
  include AuthToken

  has_secure_password

  validates_presence_of :account, :password_digest
  validates_uniqueness_of :account

  def as_api_json
    {
        account: account
    }
  end
end