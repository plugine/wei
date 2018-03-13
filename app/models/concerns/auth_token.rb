module AuthToken
  extend ActiveSupport::Concern

  included do

    def self.from_token(token)
      self.find_by(id: JWT.decode(token, nil, false).first['id'])
    end
  end

  def token
    JWT.encode({id: self.id}, nil, 'none')
  end
end