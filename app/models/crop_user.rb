class CropUser < ActiveRecord::Base
  include AuthToken

  belongs_to :company

  validates_presence_of :account, :password_digest, :phone, message: '基本信息必须填写'

  has_secure_password

  def as_json
    super.except('password_digest')
  end

end