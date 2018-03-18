class User < ActiveRecord::Base

  has_and_belongs_to_many :activities

  def as_json(*)
    super.exclude(:created_at, :updated_at)
  end
end
