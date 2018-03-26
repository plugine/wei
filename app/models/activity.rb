class Activity < ActiveRecord::Base
  belongs_to :public_account

  has_and_belongs_to_many :users

  def to_api_json
    as_json.except(:public_account_id)
  end
end