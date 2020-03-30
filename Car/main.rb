require_relative "my_car"
require_relative "fleet"
def main
    fleet = Fleet.new
    fleet.load_from_file("cars-list.json")
    
    puts fleet.average_consumption

    puts fleet.number_by_brand("BMW");

    puts fleet.number_by_model("X5 3,0D")

    puts fleet.consumption_by_brand("BMW")
end


if __FILE__ == $0
    main
end