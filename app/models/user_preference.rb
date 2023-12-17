class UserPreference
  include Mongoid::Document
  include Mongoid::Timestamps

  field :favourites, type: Array
  field :currently_watching, type: Array
  field :history, type: Array
  field :customer_id, type: Integer
end
