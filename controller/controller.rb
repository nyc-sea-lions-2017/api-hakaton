class Controller
  attr_reader :view, :industry

  def initialize(args={})
    @view = args.fetch(:view, View)
    @industry = args.fetch(:industry,'')
  end

  def run
    tse = industry.url
    list = industry.display_list
    view.attractions
    list
    input = gets.chomp.to_i
    case input
      when 1..list.length
        industry.display_clean_list(input)
      else
        puts "Please select a valid number..."
    end
  end

end
