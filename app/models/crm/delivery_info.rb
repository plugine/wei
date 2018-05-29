class DeliveryInfo < ActiveRecord::Base
  validates_presence_of :province, city, street, name, phone

  scope :mine, -> (activity_id) { where(activity_id: activity_id) }

  def create_from(activity_id, user_id, options={})
    self.create options.merge({
                                  user_id: user_id,
                                  activity_id: activity_id
                              })
  end

  def to_api_json
    {
        province: province,
        city: city,
        street: street,
        name: name,
        phone: phone,

        activity_id: activity_id
    }
  end
end