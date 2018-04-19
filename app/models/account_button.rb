class AccountButton < ActiveRecord::Base
  belongs_to :public_account

  # 创建自定义菜单
  # 详细文档请见：https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141013
  def update_account_button
    WechatService.instance.account_api(self.public_account).menu_create(JSON.parse(self.button_json))
  end
end
