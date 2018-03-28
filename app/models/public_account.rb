class PublicAccount < ActiveRecord::Base

  scope :order_desc ,->{ order(id: :desc) }

  has_many :users
  has_many :activities
  belongs_to :company


  def as_json
    super
  end
end
