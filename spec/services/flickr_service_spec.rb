require 'rails_helper'

describe FlickrService do
  context "when initialize service" do
    it "should return the instance of service with nil text" do
      service = FlickrService.new({})
      expect(service.instance_variable_get(:@text)).to be_nil
    end

    it "should return the instance of service with text" do
      service = FlickrService.new({search_input: 'test'})
      service.instance_variable_get(:@text).equal?('test')
    end
  end

  context "when search photo" do
    it "should return search data" do
      service = FlickrService.new({search_input: 'test'})
      expect(service.search).not_to be_empty
    end
    it "should not return search data and exception raised" do
      service = FlickrService.new({})
      expect { service.search }.to raise_error(InvalidRequest)
    end
    it "should not return search data when key is not valid" do
      key = ENV['flickr_api_key']
      ENV['flickr_api_key'] = '45878'
      service = FlickrService.new({search_input: 'test'})
      expect { service.search }.to raise_error(InvalidRequest)
      ENV['flickr_api_key'] = key
    end
  end

  describe "when generates a image url" do
    it "should build a correct image URL" do
      service = FlickrService.new({search_input: 'test'})
      response = service.search
      photo = response[0]
      url = build_url(photo)

      expect(service.build_img_url(photo)).to eq(url)
    end
  end
end