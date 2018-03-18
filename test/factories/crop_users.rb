FactoryGirl.define do
  factory :crop_user do
    account {(rand*10000).to_i.to_s}
    password '123456'
    phone '18351921939'
  end
end