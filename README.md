# README

Additional feature added: 
Filtering based on fields/inventory count/tags/other metadata

* Ruby version: 3.0.1 
* Heroku link: https://shopify-challenge-cathy-pham.herokuapp.com/
* Deployment instructions
Instructions on how to get the application running on your local machine:
1. Go to https://github.com/cathy-dctp/shopify_challenge
2. Open a terminal and clone your repo by taking the ssh link from github and do: 
git clone git@github.com:cathy-dctp/shopify_challenge.git cathy
3. cd cathy
4. bundle install
5. rails db:create db:migrate
6. rails server -b 0.0.0.0
7. Click on the link provided to access the app

Instructions on how to use the application:
1. This app is used to track inventory for a furniture storage.
2. In the app, user can: 
* Create a new furniture item: Items > Create New Item > Create
* Edit a furniture item: Items > Edit > Update 
* Delete a furniture item: Items > Delete 
* View a list of furniture items: All items 
* Add/ remove a tag
* Filter items by name, description, tags, supplier
