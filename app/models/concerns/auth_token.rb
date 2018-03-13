module AuthToken
  extend ActiveSupport::Concern

  included do
    def from_token(token)
      self.find_by(id: JWT.decode(token, nil, false).first)
    end
  end

  def token
    JWT.encode({id: self.id}, nil, 'none')
  end
end