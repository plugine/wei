class Payment < ActiveRecord::Base
  validates_presence_of :total_fee

  enum state: [:initialized, :paid, :refunded, :expired]

  def self.generate(options={})
    clazz = options.delete(:method).camelize.constantize
    clazz.generate options
  end
end