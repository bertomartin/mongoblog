class Article
  include Mongoid::Document
  include Mongoid::Slug
  slug :title

  validates_presence_of :title, :content, :authors

  field :authors, type: Array, default: []

  field :tag, type: Array, default: []
  field :title, type: String
  field :content, type: String  
  field :published, type: Boolean, default: false



  embeds_many :comments

  belongs_to :user
  resourcify
end
