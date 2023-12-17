class DashboardController < ApplicationController
  def index
    @movies_count = Movie.count
    @series_count = Series.count
    @customers_count = Customer.count
  end
end
