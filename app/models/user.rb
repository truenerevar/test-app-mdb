class User
  include Mongoid::Document
  include Mongoid::Timestamps	
  
  field :first_name, type: String
  field :last_name, type: String
  field :birthday, type: String
  field :address, type: String

end
