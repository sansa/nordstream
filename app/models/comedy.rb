# frozen_string_literal: true

class Comedy < ContentSchema
  self.table_name = 'VMovie_comedy'


  def favorite
    pref = UserPreference.first
    return true if pref.favourites.include? self.TMovie_id
    false
  end

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
