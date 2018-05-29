require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    account = create(:public_account)
    @activity = create(:activity, public_account: account)
  end

  test 'user should join activity' do
    user = create(:user)
    user.activities << @activity
    user.activities << @activity unless user.activities.include? @activity
    user.reload
    @activity.reload

    assert_equal @activity, user.activities.first
    assert_equal 1, user.activities.count
  end
end
