module Admin
  class ActivitiesController < BaseController
    def index
      render json: {code: 200, activities: []}
    end
  end
end