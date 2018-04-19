class TypesController < ApplicationController
  def show
    @type = ArticleType.find_by_code params[:code]
  end
end