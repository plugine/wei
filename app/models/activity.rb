class Activity < ActiveRecord::Base
  belongs_to :public_account

  has_and_belongs_to_many :users
end