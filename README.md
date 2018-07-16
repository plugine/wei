# WEI 微信服务号裂变引擎

## 创作初衷：
微信作为互联网流量生态最重要的一环，承载了大部分创业公司的品牌曝光和营销策略，其中不乏所有产品均围绕微信生态的公司。在下对于营销的理解非常的片面，将其抽象为"借势"和"造势"两个策略，
而裂变作为营销方法论最重要的一环，无论是借势还是造势，均可以使用裂变的方式拓宽曝光，增加关注。至于变现和转化，不在本项目的讨论范围内便不再赘述。

在下为多个创业公司以及自己的公司提供过裂变服务，深知裂变的核心不在于技术手段，而在于如何巧妙设计裂变灵活借势，以及如何使用有吸引力的产品或想法造势，遂决定开源这套引擎。

## 核心功能

* 服务号矩阵管理与动态配置（菜单、appid等基本信息）
* 一套完整裂变DSL(高可配置，能迅速开发出各种裂变方式)
* 高效（跑分双核4G云服务器每秒支撑1.3w + 用户裂变）
* 一套简单的支付网关(可0代码实现支付)
* 大部分前端页面变更不发版
* 快速创建静态页面

## 待完成
* 前后端分离（在下不善前端，很渣的那种）
* 完整支付及订单支持
* Docker 镜像
* 文档编写中

## 黑科技
* 虽说是服务号裂变引擎，其实订阅号也是稍微配置下可以用的
* 大量使用动态语言eval特性，灵活的同时也带来很多安全隐患，操作不慎一个运营人员就能把后台搞垮。不过也带来更多试错机会和想象力（55开吧）

## 示例
因安全原因，不提供在线demo预览，你可以手工安装到服务器进行测试。

请更改database.yml更换default和production的数据库帐密

> 
> git clone 
>
> cd wei
> 
> bundle install
>
> rake db:create db:migrate
>
> rails s

### 依赖：
* Mysql
* redis 
* ssdb (你也可以再开一个redis在8888端口替代ssdb)

### 一个简单的裂变活动：
代码：
```ruby 
joined_success '想免费包邮送点好东西

一想到初学吉他的时候手割得生疼就想放弃是吧？没关系，尼龙弦了解一下～

活动规则：
1. 邀请29个微信好友扫码即可免费包邮送。
2. 好友扫码接力时你会第一时间在公众号收到通知，同时会告知当前你的好友接力数。
3. 好友扫码接力后如果取消关注，你也会收到相应通知，好友接力数-1。

接力成功后，公众号会自动推送发货表单链接给你，填写收货地址后2天内即发货。

温馨提示：转发分享卡到朋友圈和群会大大提高活动成功率噢。'

relaied_success '你已成功接力#{relaied_user&.nickname}～'

relaied_feedback '你的好友#{user&.nickname}接力了你。当前接力人数：#{relaied_user_supporters.size}'

activity_success '你已成功完成活动：<a href="http://weixin.njupt.org/pages/delivery_le_10?openid=#{relaied_user.openid}&activity_id=#{activity.id}">点此填写收货地址</a> 我们会尽快安排发货。
嫌麻烦？加我微信 "sidekiq"，直接报地址也可以的。'

def start
  if support_success?
    say relaied_success
    say_to_relaied relaied_feedback if relaied_user
    (say_to_relaied activity_success) if relaied_user_supporters.size == 29
  end
  
  say joined_success
  
  image invite_pic("http://static.njupt.org/activity_10.jpg", [
    (image_query qr_url, 170, 'SouthWest', 60, 60, 0.25)
  ])
end
```

扫码体验：
![](img/1.jpg)
