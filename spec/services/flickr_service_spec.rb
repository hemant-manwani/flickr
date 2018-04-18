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
      response = service.search
      response['stat'].equal?('fail')
    end
    it "should not return search data when key is not valid" do
      key = ENV['flickr_api_key']
      ENV['flickr_api_key'] = '45878'
      service = FlickrService.new({search_input: 'test'})
      response = service.search
      response['stat'].equal?('fail')
      ENV['flickr_api_key'] = key
    end
    it "should not return search data when flickr_base_url is not present" do
      base_url = ENV['flickr_base_url']
      ENV['flickr_base_url'] = ''
      service = FlickrService.new({search_input: 'test'})
      response = service.search
      expect(response.blank?).to be_truthy
      ENV['flickr_base_url'] = base_url
    end
  end

  describe "when generates a image url" do
    it "should build a correct image URL" do
      service = FlickrService.new({search_input: 'test'})
      response = service.search
      photo = response['photos']['photo'][0]
      url = build_url(photo)

      expect(service.build_img_url(photo)).to eq(url)
    end
  end
end