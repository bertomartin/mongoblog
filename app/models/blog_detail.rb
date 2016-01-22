class BlogDetail
  include Mongoid::Document
  include Mongoid::Slug
  # slug :title

  # validates_presence_of :title, :content
  field :links, type: Array, default: []


end