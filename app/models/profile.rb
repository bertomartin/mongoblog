class Profile
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String

  embedded_in :user, inverse_of: :profile
end
