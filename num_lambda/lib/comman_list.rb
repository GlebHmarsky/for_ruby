# frozen_string_literal: true

require_relative 'command'
require 'csv'
# CommandList class
class CommandList
  include Enumerable 
  attr_accessor :commands
  def initialize
    @commands = []
  end

  def read_data(filename)
    commands = CommandList.new
    CSV.foreach(filename, headers: true) do |row|
      @commands.append(Command.new(
                       row[0],
                       row[1],
                       Integer(row[2]),
                       Integer(row[3])
                     ))
    end
    commands
  end

  def min
    commands.min
  end

  def max
    commands.max
  end
end
