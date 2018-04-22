module Admin
  class DashBoardsController < BaseController
    def index
      logger.info current_user.as_json
    end

    def update

    end
  end
end