class Fleet
    attr_reader :cars
    def initialize
        @cars = []
    end

    def add(new_car)
        cars.push(new_car)
    end

    def load_from_file(file)
        require 'json'
        json_data = File.read(file)
        ruby_objects = JSON.parse(json_data)
        ruby_objects.each do |car|
            add(Car.new(car['mark'], car["model"], Integer(car["year"]), Integer(car["consumption"])))

        end
    end

    def average_consumption 
        whoal_benz =0
        for car in cars do
            whoal_benz += car.benz 
        end
        return whoal_benz/cars.size
    end

    def number_by_brand(brand)
        whoal_cars_by_brand = 0
        for car in cars do
            if(car.mark.downcase == brand.downcase) 
                whoal_cars_by_brand += 1
            end
        end
        return whoal_cars_by_brand
    end

    def number_by_model(model)
        whoal_cars_by_model = 0
        for car in cars do
            if(car.model.downcase == model.downcase) 
                whoal_cars_by_model += 1
            end
        end
        return whoal_cars_by_model
    end

    def consumption_by_brand(brand)
        whoal_cars_by_brand = 0
        whoal_benz =0
        for car in cars do
            if(car.mark.downcase == brand.downcase) 
                whoal_cars_by_brand += 1
                whoal_benz += car.benz 
            end
        end  
        if(whoal_cars_by_brand <=0)
             return 0
        end
        return whoal_benz/whoal_cars_by_brand
    end
end