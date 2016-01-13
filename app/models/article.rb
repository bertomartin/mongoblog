class Article
  include Mongoid::Document
  include Mongoid::Slug
  slug :title

  validates_presence_of :title, :content

  field :tag, type: Array, default: []
  field :title, type: String
  field :content, type: String  
  field :published, type: Boolean, default: false
  

  # def tags_list=(arg)
  #   self.tag = arg.split(',').map { |v| v.strip }
  # end

  # def tags_list
  #   self.tag.join(',')
  # end

  embeds_many :comments
end
