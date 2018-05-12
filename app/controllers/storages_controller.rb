class StoragesController < ApplicationController

  # 保存一个字符串
  def create
    StorageService.instance.set(params[:key], params[:value], params[:expire])
    render json: {code: 200, key: params[:key]}
  end

  def append
    StorageService.instance.append(params[:key], params[:value], params[:expire])
    render json: {code: 200, key: params[:key]}
  end

  # 获取一个字符串
  def show
    render json: {code: 200, data: StorageService.instance.get(params[:key])}
  end
end