class PublicAccount < ActiveRecord::Base
  include Errorable

  validates_presence_of :name, :account, :appid, :appsecret
  validates_uniqueness_of :name, :appid, :account

  def to_api_json
    {
        id: id,
        name: name,
        account: account,
        appid: appid,
        created_at: created_at
    }
  end
end