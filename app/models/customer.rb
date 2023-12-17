# frozen_string_literal: true

class Customer < CustomerPaymentSchema
  self.table_name = 'TCustomer'


  def country
    country = Country.where(TCountry_code: self.TCustomer_tcountry_code).first
    country.nil? ? 'N/A' : country.TCountry_name
  end
end
