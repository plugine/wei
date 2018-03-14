class Activity < ActiveRecord::Base
  validates_presence_of :name, :author, :code_template, :constants
  validates_uniqueness_of :name
end