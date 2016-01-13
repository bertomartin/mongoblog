class Article
  include Mongoid::Document

  field :title, type: String
  field :content, type: String
  field :published, type: Boolean, default: false
end
