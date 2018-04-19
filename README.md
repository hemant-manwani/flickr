# README

This Ruby On Rails app displays the search results for images on flickr. A search input string is give to discover photos.

Features:

1. Search box
2. List results
3. Pagination

Please setup the project by the following steps:

1. Clone this repository in your local environment

2. ```cd``` in the cloned repository and execute ```bundle install```

3. Execure ```rake db:create``` followed by ```rake db:migrate```

4. Generate Flickr `flickr_api_key`, `flickr_shared_secret` and put them in the file `confg/application.yml` along with `results_per_page` and `flickr_base_url`. Please use the `application.yml.template` for this purpose, you can rename this file to `application.yml` and put your registered API values.

5. Star rails puma server using ```rails s```.

6. To run test cases, open a separate console and please run `rspec` in the project directory.
