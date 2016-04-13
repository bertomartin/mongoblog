class Note
  include Mongoid::Document

  field :notes_info, type: String
  
  embedded_in :article, inverse_of: :notes
end