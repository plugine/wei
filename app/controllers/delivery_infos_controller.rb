class DeliveryInfosController < ApplicationController
  before_action :set_user

  def create
    info = @current_user.delivery_infos.mine(params[:activity_id]).first
    if info
      info.update delivery_info_params
    else
      info = DeliveryInfo.create_from(params[:activity_id], @current_user.id, delivery_info_params)
    end
    render json: {code: 200, info: info.to_api_json}
  end

  private
  def set_user
    @current_user = User.find_by_openid params[:openid]
  end

  def delivery_info_params
    params.require(:delivery_info).permit(:province, :city, :street, :name, :phone)
  end
end