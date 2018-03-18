FactoryGirl.define do
  factory :public_account do
    name {(rand*1000).to_i.to_s}
    account {(rand*1000).to_i.to_s}
    appid 'wx992037f0a32db788'
    appsecret 'ebf11ea81d4887f9fd26987241262913'
  end

end
