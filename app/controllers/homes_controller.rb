require 'open-uri'

class HomesController < ApplicationController

  # Load different genres from the materialized views
  def index
    @comedies = Comedy.limit(10).all
    @adventures = Adventure.limit(10).all
  end

  # Add or remove movies from the list of favourites
  def favourites
    movie_id = params[:id].to_i
    prefs = UserPreference.first
    if prefs.favourites.include? movie_id
      prefs.favourites.delete(movie_id)
    else
      prefs.favourites.push(movie_id)
    end
    prefs.save!
    redirect_to homes_path
  end

  # Get the movie url from the moviecovers table from Mongo
  # Play video using URL
  def play
    movie_id = params[:id].to_i
    update_history(movie_id)
    content = MovieCover.where(movie_id: movie_id).first
    @url = content.movie_url
  end

  def update_history(movie_id)
    prefs = UserPreference.first
    prefs.history = [] if prefs.history.nil?
    prefs.history.push movie_id unless prefs.history.include? movie_id
    prefs.save!
  end
end
