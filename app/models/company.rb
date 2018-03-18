class Company < ActiveRecord::Base

  validates_presence_of :name, message: '公司名称必须填写'
  validates_uniqueness_of :name, message: '公司已经存在'

  has_many :crop_users
  has_many :public_accounts
end