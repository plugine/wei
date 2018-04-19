class ArticleType < ActiveRecord::Base
  # name: 文章分类名称
  # code: 文章公网访问时的url识别码，只支持英文和数字

  validates_presence_of :name, :code

  belongs_to :public_account
  has_many :pages
end
