# frozen_string_literal: true

require_relative 'comman_list'

require 'pathname'
# require 'optparse'

# C class
class Creator
  def create
    pn = Pathname.new(File.expand_path('../data/2019-ti-group-stage.csv', __dir__))
    unless pn.exist?
      puts 'Нет такого файла!'
      nil
    end
    cl = CommandList.new
    cl.read_data pn.to_path
  end
end
