require_relative "../lib/my_car"
require_relative "../lib/fleet"
def main
    fleet = Fleet.new
    fleet.load_from_file(__dir__<<"/../data/cars-list.json")
    
    puts fleet.average_consumption

    puts fleet.number_by_brand("BMW");

    puts fleet.number_by_model("X5 3,0D")

    puts fleet.consumption_by_brand("BMW")
end


if __FILE__ == $0
    main
end