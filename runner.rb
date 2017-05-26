require_relative 'model/industry'
require_relative 'view/view'
require_relative 'controller/controller'
require 'pry'
require 'json'
require 'open-uri'

industry = Industry.new(url:"https://data.cityofnewyork.us/resource/2pc8-n4xe.json")
controller = Controller.new(view:View,industry:industry)
# binding.pry
controller.run




