class PublicAccount < ActiveRecord::Base

  scope :order_desc ,->{ order(id: :desc) }

  has_many :users
  has_many :activities, dependent: :destroy
  has_many :conditions, dependent: :destroy
  belongs_to :company


  def to_api_json
    {
        id: id,
        name: name,
        account: account,
        appid: appid,
        appsecret: appsecret,
        created_at: created_at.strftime('%Y-%m-%d'),
        company: {
            id: company_id,
            name: company.name
        }
    }
  end
end
