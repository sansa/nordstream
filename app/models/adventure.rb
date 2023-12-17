# frozen_string_literal: true

class Adventure < ContentSchema
  self.table_name = 'VMovie_adventure'

  def favorite
    pref = UserPreference.first
    return true if pref.favourites.include? self.TMovie_id
    false
  end


  # Get Image URL from mongoDB
  # Load from local filesystem if not in DB (This only applies to first few data that were added to test the UI)
  def image
    img = MovieCover.where(movie_id: self.TMovie_id).first

    if img.nil?
      url = "/assets/img/#{self.TMovie_id}.jpeg"
    else
      url = img.image_url
    end
    url
  end

end
