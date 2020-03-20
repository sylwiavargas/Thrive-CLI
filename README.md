# THRIVE

An interactive CLI guide on how to survive web dev bootcamps, based on data collected from scraped websites, as well as API's, and our own personal entries.

It consists of multiple pages with unique information, images, animations and an option for audio description and audio guidance for accessibility.

It was developed as a Flatiron School’s mod1 group project to demonstrate the knowledge of Active Record Associations, as well as CRUD methods, and database management. 



## Getting Started
Clone this project into your local machine and follow the instructions below.

Installing
After cloning the project folder onto your local machine, take the following steps:

Install the gems required for the guide by running the following command from the project folder.

bundle install
Create the necessary tables by running migrations.

rake db:migrate
Seed the database with the information needed to run the app (this may take a while).

rake db:seed
To start, run the following command from you project folder.

Ruby bin/run.rb



## Navigation of CLI

Welcome page (select audio on/off option)

Open Home Page

Create a user login

Read tips from database and save them with a label and a comment

Search Google for more info

Take part in various exercises and explore the app

Update your tip directory by label

Delete a tip directory

Exit


#### Built with

 Meetup API
 Quotes REST API
'formatador' - styling output information into a neat table
'artii' - creating text banners
'Colorize' - enabling text coloring
'lolcat' - enabling rainbow text coloring
'sinatra-activerecord'
'sqlite3'
'require_all'
'pry'
'json'
'Faker' - autogenerating fake seed data
'tty-prompt' - enabling beautiful and easy option selection and user input
'nokogiri' - web scraping
'rest-client' - API calls


#### Contributing
Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.


#### Authors
See the list of contributors who participated in this project.
