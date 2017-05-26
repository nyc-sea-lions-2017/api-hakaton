require 'pry'
require 'json'
require 'open-uri'


tse = "https://data.cityofnewyork.us/resource/2pc8-n4xe.json"


def tsev_subindustry_list(url)
  tse_string_response = open(url).read
  tse_hash_response = JSON.parse(tse_string_response)
  tse_hash_response.map! {|industry| industry["subindustry"] }.uniq
end

list = tsev_subindustry_list(tse)

def tsev_subindustry_filtered(url,input)
  query = "subindustry="
  tse_string_response = open(url+ "?" + query + input).read
  tse_hash_response = JSON.parse(tse_string_response)
end


def display_list(url)
  list = tsev_subindustry_list(url)
  list.each.with_index do |industry, index|
    puts "#{index + 1}- #{industry}"
  end
end

def display_clean_list(url, input)
  list = tsev_subindustry_filtered(url, tsev_subindustry_list(url)[input-1])
  list.each do |option|
  keys = option.keys
  values = option.values
  industry_info = keys.zip(values)
  industry_info.each do |industry|
  puts "#{industry[0]}, #{industry[1]}"
  end
    puts "\n"
  end
end

list = display_list(tse)

puts "Here are the types of attractions you can go to:"
list
input = gets.chomp.to_i

case input
  when 1..list.length
    display_clean_list(tse, input)
  else
    puts "Please select a valid number..."
end
