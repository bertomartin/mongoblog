class UserSubscription
  include Mongoid::Document

  validates_presence_of :email

  field :email, type: String

end
