# require 'flickraw'

# module Flickr
# 	def self.search
#     binding.pry
  end
	# class FlickRaw::Response
	#   def url_q
	#     build_img_url.gsub('?', 'q')
	#   end

	#   def url_c
	#     build_img_url.gsub('?', 'c')
	#   end

	#   def build_img_url
	#     "https://farm#{self.farm}.staticflickr.com/#{self.server}/#{self.id}_#{self.secret}_?.jpg"
	#   end
	# end
# end
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