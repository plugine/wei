FactoryGirl.define do
  factory :user_admin_user, class: 'User::AdminUser' do
    account 'admin'
    password '123321'
  end
end