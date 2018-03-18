require 'test_helper'

class Admin::PublicAccountsControllerTest < ActionController::TestCase
  setup do
    @company = create(:company)
    @user = create(:crop_user, company: @company)
    @account = create(:public_account, company: @company)
  end

  test 'should get index' do
    get :index, Authentication: @user.token
    assert JSON.parse(response.body)['public_accounts'].length > 0
  end

  test 'should update a public account' do
    account = create(:public_account, company: @company)
    post :update, Authentication: @user.token, id: account, name: '123'
    account.reload
    assert_equal '123', account.name
    assert_response :success
  end

  test 'should raise permission error' do
    account = create(:public_account, company: create(:company))
    post :update, Authentication: @user.token, id: account, name: '123'
    assert_equal 401, JSON.parse(response.body)['code']
  end
end