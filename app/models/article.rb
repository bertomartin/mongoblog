class Article
  include Mongoid::Document
  include Mongoid::Slug
  slug :title

  field :title, type: String
  field :content, type: String
  field :published, type: Boolean, default: false
end
