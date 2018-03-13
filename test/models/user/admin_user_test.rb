require 'test_helper'

module User
  class AdminUserTest < ActiveSupport::TestCase
    setup do
      @admin = create(:user_admin_user)
    end

    test 'test encode and decode user by jwt token' do
      token = @admin.token
      same_user = AdminUser.from_token(token)
      assert_equal @admin.id, same_user.id, message: '就是同一个用户'
    end
  end
end