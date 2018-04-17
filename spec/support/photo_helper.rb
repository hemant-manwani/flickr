module Photo
  def build_url(photo)
    "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_q.jpg"
  end
end