class Remind < ActiveRecord::Base
  enum state: [:initialized, :done]

  validates_uniqueness_of :title, message: '提醒事项标题不能重复'



end