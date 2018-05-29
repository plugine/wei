class User < ActiveRecord::Base
  include ActivityConstant
  include ErrorConst
  include Userable

  has_and_belongs_to_many :activities
  has_many :orders
  has_many :delivery_infos

  def self.create_from_hash(account_id, info)
    self.create info.symbolize_keys
                    .except(:tag_list, :subscribe)
                    .merge({
                        public_account_id: account_id,
                        alive: true})
  end
end
