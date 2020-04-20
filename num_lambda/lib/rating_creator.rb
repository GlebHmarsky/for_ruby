# frozen_string_literal: true

require_relative 'comman_list'

require 'optparse'
require 'pathname'

# RC class
class RatingCreator
  def create
    pn = Pathname.new(File.expand_path('../data/2019-ti-group-stage.csv', __dir__))
    unless pn.exist?
      puts 'Нет такого файла!'
      nil
    end
    ml = CommandList.new
    ml.read_data pn.to_path
    pp ml.commands
    
  end

  def show_min_max(ml)
    puts ml.min
    puts ml.max
  end
end
