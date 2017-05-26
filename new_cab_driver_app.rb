require 'open-uri'
require 'date'
require 'json'


BASE_URL = "https://data.cityofnewyork.us/resource/xtra-f75s.json"

APP_NUMBER_QUERY = "app_no="
APP_MONTH_QUERY = "app_date="
APP_COMPLETE_QUERY = "drug_test="
APP_EXAM_QUERY = "driver_exam="

puts "Welcome to the New York City Department of Transportation New Cab Driver Database!"
puts "*" * 110

def print_data(data_array)
   data_array.each do |hash|
    puts "-----------------------------------------------------------------------------------------------------------------------------\n"
    hash.each {|key,value| puts "#{key}:".ljust(50)  + "#{value}".rjust(75)}
    end
end


search_for = nil

until search_for == "exit"
  puts "What would you like to search for? If done, enter exit."
  search_for = gets.chomp.downcase

  case search_for
  when "application number"
    puts "What application number would you like to search for? "
    number = gets.chomp

    search = open(BASE_URL + "?" + APP_NUMBER_QUERY + number).read

    parsed_search = JSON.parse(search)

    print_data(parsed_search)

  when "month"
    puts "What month number (two digits) would you like to search for? (returns values for all years of specified month)"
    searched_month = gets.chomp.to_i

    data_object = open(BASE_URL)
    read_data = data_object.read
    parsed_data = JSON.parse(read_data)

    search = []
    parsed_data.select do |hash|
      hash.each do |key,value|
        if key == "app_date"
          value =  DateTime.parse(value).to_time
          if value.month == searched_month
            search << hash
          end
        end
      end
      search
    end

    print_data(search)

  when "year"
    puts "What year (four digits) would you like to search for?"
    searched_year = gets.chomp.to_i

    data_object = open(BASE_URL)
    read_data = data_object.read
    parsed_data = JSON.parse(read_data)

    search = []
    parsed_data.select do |hash|
      hash.each do |key,value|
        if key == "app_date"
          value =  DateTime.parse(value).to_time
          if value.year == searched_year
            search << hash
          end
        end
      end
      search
    end

    print_data(search)

  when "drug test"
    puts "Would you like to search for complete or needed drug tests?"
    answer = gets.chomp

    search = open(BASE_URL + "?" + APP_COMPLETE_QUERY + answer).read
    parsed_search = JSON.parse(search)

    print_data(parsed_search)

  when "driver exam"
    puts "Would you like to search for complete or needed driver exams?"
    answer = gets.chomp

    search = open(BASE_URL + "?" + APP_EXAM_QUERY + answer).read
    parsed_search = JSON.parse(search)

    print_data(parsed_search)

  else
    puts "Not sure what you're searching for here."
  end
end
