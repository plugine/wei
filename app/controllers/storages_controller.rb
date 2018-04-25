class StoragesController < ApplicationController

  # 保存一个字符串
  def create
    $redis.pipelined do
      $redis.set params[:key], params[:value].to_s
      $redis.expire(params[:key], params[:expire]) if params[:expire].present?
    end
    render json: {code: 200, key: params[:key]}
  end

  # 获取一个字符串
  def show
    render json: {code: 200, data: ($redis.get params[:key])}
  end
end