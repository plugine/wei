class Event < ActiveRecord::Base
  validates_presence_of :event_type, :action_type

  belongs_to :public_account
end
