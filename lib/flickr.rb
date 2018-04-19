require 'httparty'

class Flickr
  include HTTParty
  base_uri 'https://api.flickr.com'

  def api_key
    ENV['flickr_api_key']
  end

  def base_path
    "/services/rest/?method=flickr.photos.search&api_key=#{ api_key }"
  end

  def self.search(search_text, options = {})
    handle_timeouts do
      url = "#{ base_path }&text=#{ search_text }&format=json&nojsoncallback=1"
      self.class.get(url, options)['data']['results']
    end
  end
end