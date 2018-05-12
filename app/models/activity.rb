class Activity < ActiveRecord::Base
  TICKET_BASE = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket='
  QINIU_BASE = 'http://searchnerd.qiniudn.com/'

  after_commit { Rails.cache.delete Activity.cache_key(self.id) }

  belongs_to :public_account

  has_and_belongs_to_many :users

  after_commit :refresh_template, on: [:create, :update]

  validates_presence_of :name, :public_account_id

  def refresh_template
    File.open(filename, 'w') {|f| f.write prepare_template}
    load_activity
  end

  def refresh_activity_qr
    api = WechatService.instance.account_api public_account
    ticket = (api.qrcode_create_limit_scene "base_#{self.id}")['ticket']
    puts ticket
    update qrurl: "#{TICKET_BASE}#{ticket}"
  end

  def to_api_json
    {
        id: id,
        name: name,
        author: author,
        desc: desc,
        consts: consts,
        template: template,
        qrurl: qrurl,
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
    load filename
  end

  def self.fetch(id)
    Rails.cache.fetch(cache_key(id)) { self.find(id) }
  end

  def self.cache_key(id)
    "activity:#{id}"
  end

  private

  def prepare_template
    <<END_OF_PREPARE
    class Activity#{id}
      include ErrorConst
      include Activitiable
      
      def initialize(activity, user, api, account, message, join_result)
        @activity = activity
        @user = user
        @api = api
        @account = account
        @message = message
        @join_result = join_result
      end

      #{template}
    end
END_OF_PREPARE
  end

  def filename
    "#{Rails.root}/tmp/activities/#{public_account_id}_#{id}.rb"
  end
end