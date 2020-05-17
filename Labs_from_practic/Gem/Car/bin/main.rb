# frozen_string_literal: true

require_relative '../lib/my_car'
require_relative '../lib/fleet'

require 'tty-prompt'


def main
  fleet = Fleet.new
  prompt = TTY::Prompt.new
  if(prompt.yes?("Do you wanna read from file?"))
    fleet.load_from_file(File.expand_path('../data/cars-list.json', __dir__))
  else 
	 	fleet.load_from_stream
  end
  puts fleet.average_consumption

  puts fleet.number_by_brand('BMW')

  puts fleet.number_by_model('X5 3,0D')

  puts fleet.consumption_by_brand('BMW')
end

main if __FILE__ == $PROGRAM_NAME
