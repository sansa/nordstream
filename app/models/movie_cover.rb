# frozen_string_literal: true

class MovieCover

  include Mongoid::Document
  include Mongoid::Timestamps

  field :movie_id, type: Integer
  field :image_url, type: String
  field :movie_url, type: String

end
