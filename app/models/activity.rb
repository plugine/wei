class Activity < ActiveRecord::Base
  belongs_to :public_account

  has_and_belongs_to_many :users

  after_create :save_template

  validates_presence_of :name, :public_account_id

  def refresh_template
    File.open(filename, 'w') {|f| f.write prepare_template}
  end

  def to_api_json
    {
        id: id,
        name: name,
        author: author,
        desc: desc,
        consts: consts,
        template: template,
        idx: idx,
        created_at: created_at.strftime("%Y-%m-%d"),
        public_account: {
            id: public_account_id,
            name: public_account.name
        }
    }
  end

  def prepare_class_name
    "Activity#{id}"
  end

  def load_activity
    require filename
    prepare_class_name.constantize
  end

  private

  def prepare_template
    prepared = <<END_OF_PREPARE
    class Activity#{id}
      include Activitiable
      
      #{template}
    end
END_OF_PREPARE
  end

  def filename
    "#{Rails.root}/#{public_account_id}_#{id}.rb"
  end
end