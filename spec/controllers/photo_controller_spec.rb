require 'rails_helper'

describe PhotoController, :type => :controller do
  context 'when searching for photos' do
    it 'should return maximum items for a popular search' do
      get :index, params: { search_input: 'cats' }
      expect(assigns(:results).length).to eq(ENV['results_per_page'].to_i)
    end

    it 'should return zero items for a rubbish search' do
      get :index, params: { search_input: 'hjgh@77876776*454455' }
      expect(assigns(:results).length).to eq(0)
    end

    it 'should return zero items for a flickr_base_url is not present' do
      base_url = ENV['flickr_base_url']
      ENV['flickr_base_url'] = ''
      get :index, params: { search_input: 'cats' }
      expect(assigns(:results)).to be_nil
      expect(flash[:error_msg]).to be_present
      ENV['flickr_base_url'] = base_url
    end

    it 'should contain different results on page 2' do
      get :index, params: { search_input: 'cats' }
      list1 = assigns(:results)

      get :index, params: { search_input: 'cats', page: 2 }
      list2 = assigns(:results)

      expect(list1).not_to match_array(list2)
    end
  end
end