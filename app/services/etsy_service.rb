require 'open-uri'
require 'json'

class EtsyService
  BASE_URL = 'https://openapi.etsy.com/v2/'

  def initialize
    @api_key = ENV['ETSY_API_KEY']
    # Additional setup if needed
  end

  def fetch_active_listings(shop_id)
    url = "#{BASE_URL}shops/#{shop_id}/listings/active?api_key=#{@api_key}"
    begin
      response = URI.open(url).read
      listings = JSON.parse(response)
      listings['results'].each do |listing|
        puts "Title: #{listing['title']}"
        # Process each listing as needed
      end
    rescue OpenURI::HTTPError => e
      Rails.logger.error("Etsy API Request failed: #{e.message}")
      # Handle error appropriately
    end
  end
end