class PublicAccount < ActiveRecord::Base

  scope :order_desc ,->{ order(id: :desc) }

  has_many :users
  has_many :activities, dependent: :destroy
  has_one :account_button, dependent: :destroy
  belongs_to :company

  # 创建自定义菜单
  # 详细文档请见：https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141013
  def update_account_button
    Rails.logger.info "update_account_button"
    WechatService.instance.account_api(self).menu_create(JSON.parse(self.menu_json))
  end

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
