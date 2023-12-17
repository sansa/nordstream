class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
  end

  def show
  end
end
