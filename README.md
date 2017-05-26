API Hackathon

Specs:

Ask user for data
Query any available web API endpoint for data, based on user input
Manipulate that data in a Ruby MVC command line app
Display to the user the data they asked for via the command line
API Resources:

List of most popular APIs utilized in hackathons
Understanding and consuming APIs and data
Accessing APIs with Ruby: a tutorial
JSONView Chrome Extension
Example in Ruby: below is a non-MVC command-line app that returns parking ticket info for a specific license plate, from the NYC 2015 parking ticket API:

# this library is best for making http requests
# and handling http responses:
require 'open-uri'

# this library is for handling json strings (parsing and creating):
require 'json'

# NYC Open Data: Parking tickets 2015 API endpoint:
BASE_URL = "https://data.cityofnewyork.us/resource/aagd-wyjz.json"

# query field for searching by plate_id:
PLATE_ID_QUERY = "plate_id="

# get user input (this would be a concern for your View)
puts "what is the license plate number you want to search for?"
user_input = gets.chomp

# make http request to api endpoint for specific plate_id,
# which will return a json string in http response:
json_string_response = open(BASE_URL + "?" + PLATE_ID_QUERY + user_input).read

# parse json string into a Ruby array of hashes
ruby_hash_response = JSON.parse(json_string_response)

# now you can manipulate the data in the Ruby hashes
# (encapsulate into Ruby objects, etc.)
# here are the Ruby hashes:
p ruby_hash_response

# Note: In your app you will need to prettify the displaying of data!
