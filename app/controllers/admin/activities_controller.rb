module Admin
  class ActivitiesController < BaseController

    def index
      render json: {code: 200, activities: Activity.all.map(&:to_api_json)}
    end
  end
end