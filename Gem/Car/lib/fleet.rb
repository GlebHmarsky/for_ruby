# frozen_string_literal: true

# Fleet class
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
      add(Car.new(car['mark'], car['model'], Integer(car['year']), Integer(car['consumption'])))
    end
  end

  def average_consumption
    whoal_benz = 0
    cars.each do |car|
      whoal_benz += car.benz
    end
    whoal_benz / cars.size
  end

  def number_by_brand(brand)
    whoal_cars_by_brand = 0
    cars.each do |car|
      whoal_cars_by_brand += 1 if car.mark.downcase == brand.downcase
    end
    whoal_cars_by_brand
  end

  def number_by_model(model)
    whoal_cars_by_model = 0
    cars.each do |car|
      whoal_cars_by_model += 1 if car.model.downcase == model.downcase
    end
    whoal_cars_by_model
  end

  def consumption_by_brand(brand)
    whoal_cars_by_brand = 0
    whoal_benz = 0
    cars.each do |car|
      if car.mark.downcase == brand.downcase
        whoal_cars_by_brand += 1
        whoal_benz += car.benz
      end
    end
    return 0 if whoal_cars_by_brand <= 0

    whoal_benz / whoal_cars_by_brand
  end
end
