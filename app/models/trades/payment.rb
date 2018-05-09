class Payment < ActiveRecord::Base
  validates_presence_of :total_fee

  belongs_to :order

  enum state: [:initialized, :paid, :refunded, :expired]

  def pay!
    self.update state: :paid
  end

  def self.generate(options={})
    clazz = options.delete(:method).camelize.constantize
    clazz.generate options
  end
end