class BlogDetail
  include Mongoid::Document
  include Mongoid::Slug
  slug :author

  validates_presence_of :author, :topics

  field :author, type: String
  field :social_accounts, type: Array, default: []
  # field :links, type: Array, default: []
  field :blog_title, type: String
  field :blurb, type: String
  field :topics, type: Array

end