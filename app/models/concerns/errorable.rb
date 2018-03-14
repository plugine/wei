module Errorable
  extend ActiveSupport::Concern

  included do

    def error_message
      self.errors.messages.reduce {|e1, e2| e1 + "\n" + e2}
    end

  end

end