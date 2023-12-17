class Admin::SeriesController < ApplicationController

  def index
    @series = Series.all
  end

  def create
    begin
      @series = Series.new
      params[:movie].each{ |k,v| @series.send("TSeries_#{k}=",v) }
      @series.save!

    rescue StandardError => e
      p "Error: #{e.message}"
    end


  end

  def show
  end

  def new
    @series = Series.new
  end

end
