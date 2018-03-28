module Admin
  class ActivitiesController < BaseController

    def index
      render json: {code: 200, activities: Activity.all.map(&:to_api_json)}
    end

    def create
      @activity = Activity.new activity_params
      return render json: {code: 419, error: @activity.errors.to_s} unless @activity.save
      render json: {code: 200}
    end

    def show
      @activity = Activity.find(params[:id])
      render json: {code: 200, activity: @activity.to_api_json}
    end

    private

    def activity_params
      params.permit(:name, :author, :desc, :template, :idx, :public_account_id)
    end
  end
end