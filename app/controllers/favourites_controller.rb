class FavouritesController < ApplicationController
  #get the ID of the favourites from the User Preferences
  # Use the IDs to load the favourites from the Movie Table
  def index
    favs = UserPreference.first.favourites
    @movies = Movie.where(TMovie_id: favs).all
  end
end
