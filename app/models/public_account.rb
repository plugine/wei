class PublicAccount < ActiveRecord::Base

  scope :order_desc ,->{ order(id: :desc) }

  has_many :users
  belongs_to :company
end
