class Article
  include Mongoid::Document
  include Mongoid::Slug
  slug :title

  validates_presence_of :title, :content

  field :tag, type: Array, default: []
  field :title, type: String
  field :content, type: String  
  field :published, type: Boolean, default: false

  embeds_many :comments

  # def self.tagged(name)
  # 	tag_list = self.all_in(tag: name)
  # end 
end
