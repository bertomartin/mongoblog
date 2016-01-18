class Page
  include Mongoid::Document
  include Mongoid::Slug
  field :name, type: String
  field :content, type: String
  slug :name
end
