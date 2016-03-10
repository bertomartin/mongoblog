class Setting
  include Mongoid::Document
  field :how_to_email, type: String

  belongs_to :user
end
