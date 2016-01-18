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
<<<<<<< HEAD

  # def self.tagged(name)
  # 	tag_list = self.all_in(tag: name)
  # end 
=======
  belongs_to :user
  resourcify
>>>>>>> e19e36e5992f0dc0768dc48eaef59c4679530d36
end
