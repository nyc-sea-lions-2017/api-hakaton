class IndustryList
  attr_reader :url
  def initialize(args={})
    @url = args.fetch(:url, '')
  end

  def tsev_subindustry_list
    tse_string_response = open(url).read
    tse_hash_response = JSON.parse(tse_string_response)
    tse_hash_response.map! {|industry| industry["subindustry"] }.uniq
  end



  def tsev_subindustry_filtered(input)
    query = "subindustry="
    tse_string_response = open(url+ "?" + query + input).read
    tse_hash_response = JSON.parse(tse_string_response)
  end


  def display_list
    list = tsev_subindustry_list
    list.each.with_index do |industry, index|
      puts "#{index + 1}- #{industry}"
    end
  end


  def display_clean_list(input)
    list = tsev_subindustry_filtered(tsev_subindustry_list[input-1])

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

end
