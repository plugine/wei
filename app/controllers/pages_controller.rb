class PagesController < ApplicationController
  def show
    @page = Page.find_by_code params[:code]
    @params = params
    @controller = self
    @request = request

    if @page.page_type == 'raw'
      render inline: @page.content, type: :rhtml
    else
      render :article, layout: false
    end
  end
end