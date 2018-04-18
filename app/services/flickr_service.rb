class FlickrService
  def initialize(params)
    @base_url = ENV['flickr_base_url']
    @api_key = ENV['flickr_api_key']
    @base_path = "#{@base_url}/services/rest/?method=flickr.photos.search&api_key=#{ @api_key }"
    @text = params[:search_input]
  end

  def search
    url = "#{ @base_path }&text=#{ @text }&format=json&nojsoncallback=1"
    response = Typhoeus.get(url)
    JSON.parse(response.body) rescue {}
  end

  def build_img_url(photo)
    "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_q.jpg"
  end
end
