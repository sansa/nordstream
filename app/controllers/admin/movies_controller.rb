require 'faker'
class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.limit(20).all
  end

  def create
    begin
      @movie = Movie.new

      # Using Ruby's MetaProgramming to dynamically assign values to their
      # respective keys as opposed to having multiple lines to assign values one by one
      params[:movie].each do |k,v|
        unless k == 'cover_image' || k == 'movie_content'
          @movie.send("TMovie_#{k}=",v)
        end

      end
      @movie.save!
      image_data = params[:movie][:cover_image]
      movie_data = params[:movie][:movie_content]
      @movie.upload_to_gcs(image_data, movie_data)

      redirect_to admin_movies_path
    rescue StandardError => e
      @movie.destroy! unless @movie.nil?
      p "Error: #{e.message}"
    end


  end

  def upload_sample_data
    absolute_file_path = Rails.root.join('public', 'movies-2020s.json')


    if File.exist?(absolute_file_path) && File.extname(absolute_file_path) == '.json'

      json_data = File.read(absolute_file_path)

      movie_array = JSON.parse(json_data)

      movie_array.each_slice(50) do |movies_batch|
        movies_batch.each do |movie|
          next if movie['cast'].blank?
          next if movie['genres'].blank?
          next if movie['thumbnail'].blank?
          next if movie['year'].blank?
          next if movie['extract'].blank?
          actors = movie['cast'][0,2]
          new_movie = Movie.new
          new_movie.TMovie_title = movie['title']
          new_movie.TMovie_actors = actors.join(',')
          new_movie.TMovie_genre = movie['genres'][0]
          new_movie.TMovie_length = rand(60..180)
          new_movie.TMovie_des = movie['extract'].truncate(100)
          new_movie.TMovie_release = movie['year']
          new_movie.TMovie_director = Faker::Name.name
          new_movie.save
          image_data = URI.open(movie['thumbnail']).read
          new_movie.upload_sample_to_gcs(image_data)
        end

      end

      render json: {message: "Successfully Uploaded Movies"}
    else

      render json: {message: "File not found or not a JSON file."}
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

end
