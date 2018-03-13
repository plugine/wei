class PublicAccount < ActiveRecord::Base
  validates_presence_of :name, :appid, :appsecret
  validates_uniqueness_of :name, :appid
end