# README

This project allows users to upload/edit/delete images to galleries. They can also explore, search and look at other galleries. 

* Ruby version: 3.1.3

If running the code in a rails server, it is recommended to use the following commands:
- bundle install
- rails db:migrate
- ./bin/dev

Testing was done to ensure that all main features are working properly. To run the tests:
- bundle exec rspec spec

A docker repository has been created for this project

Make sure you have docker installed in your machine

To run the code run: 
- docker run -dp 3000:3000 ianvexler/image-gallery
- docker run IMAGE_ID
