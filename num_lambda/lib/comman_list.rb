# frozen_string_literal: true

require_relative 'command'
require 'csv'
# CommandList class
class CommandList
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

  def commands_to_hash
    teams = Hash.new(0)
    @commands.each do |tur|
      teams[tur.com_one] += tur.score_one
      teams[tur.com_two] += tur.score_two
    end
    teams
  end

  def add(new_com)
    @commands.append(new_com)
    commands_to_hash
  end
  def hash_to_a(hteam)
    arr = hteam.to_a.map { |t| t[0] }.sort
    return arr.each unless block_given?

    arr.each do |t|
      yield t
    end
  end

  def hash_sort_by_score(hteam)
    arr = hteam.to_a.sort { |a, b| a[1] <=> b[1] }.map { |t| t[0] }.reverse
    return arr.each unless block_given?

    arr.each do |t|
      yield t
    end
  end

  def yield_delete(arr)
    return unless block_given?
    yield arr.delete_if 
  end
end
