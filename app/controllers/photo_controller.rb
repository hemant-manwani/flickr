require 'will_paginate/array'

class PhotoController < ApplicationController
  def index
    if params[:search_input].present?
      @service = FlickrService.new(params)
      results = @service.search
      return @results = results['photos']['photo'].paginate(page: params[:page], per_page: ENV['results_per_page']) if results['photos'].present?
      flash.now[:error_msg] = results['message'] || "Something went wrong.."
    end
  end
end