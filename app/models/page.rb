class Page < ActiveRecord::Base

  validates_presence_of :title, :code, :content

  # page_type:
  #   raw: 存html渲染
  #   article: 使用文章模版渲染
  validates_inclusion_of :page_type, in: %w(raw article)

  belongs_to :public_account
  belongs_to :article_type


end