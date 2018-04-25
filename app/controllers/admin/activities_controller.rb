module Admin
  class ActivitiesController < BaseController
    before_action :set_activity, except: [:index, :new, :create]

    def index
      @activities = Activity.all
      respond_to do |format|
        format.json { render json: {code: 200, activities: @activities.map(&:to_api_json)} }
        format.html
      end
    end

    def new
      @activity = Activity.new
      @accounts = current_user.company.public_accounts.all
    end

    def edit
      @accounts = current_user.company.public_accounts.all
    end

    def create
      @activity = Activity.new activity_params

      respond_to do |format|
        if @activity.save
          format.json { render json: {code: 200} }
          format.html { redirect_to admin_activities_path, alert: '创建成功' }
        else
          errors = @activity.errors.to_a.join '\n'
          format.json { render json: {code: 419, error: errors} }
          format.html { redirect_to :back, alert: errors }
        end
      end
    end

    def refresh_qr
      @activity.refresh_activity_qr
      redirect_to :back
    end

    def show
      render json: {code: 200, activity: @activity.to_api_json}
    end

    def destroy
      @activity.delete
      render json: {code: 200}
    end

    def update
      if @activity.update_attributes activity_params
        respond_to do |format|
          format.json { render json: {code: 200} }
          format.html { redirect_to :back, flash: {alert: '更新成功'} }
        end
      else
        errors = @activity.errors.to_a.join '\n'
        respond_to do |format|
          format.json { render json: {code: 419, error: errors} }
          format.html { redirect_to :back, flash: {alert: errors} }
        end
      end
    end

    private

    def activity_params
      params.require(:activity).permit(:name, :author, :desc, :template, :public_account_id, :event_key)
    end

    def set_activity
      @activity = Activity.find(params[:id])
    end
  end
end