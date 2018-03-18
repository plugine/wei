require 'test_helper'

class Admin::LoginsControllerTest < ActionController::TestCase
  setup do
    @user = create(:crop_user, company: create(:company))
  end

  test 'test login' do
    post :create, account: @user.account, password: '123456'
    assert_response :success
    assert_equal 200, JSON.parse(response.body)['code']
  end
end