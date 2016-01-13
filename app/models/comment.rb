class Comment
  include Mongoid::Document
  validates_presence_of :body

  field :name, type: String
  field :body, type: String
  field :published, type: Boolean, default: true

  embedded_in :article, inverse_of: :comments
end
