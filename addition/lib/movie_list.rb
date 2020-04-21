# frozen_string_literal: true

require_relative 'movie'
require 'csv'
# MovieList class
class MovieList
  include Enumerable 
  attr_accessor :movies
  def initialize
    @movies = []
  end

  def read_data(filename)
    movies = MovieList.new
    CSV.foreach(filename, headers: true) do |row|
      @movies.append(Movie.new(
                       row['title'],
                       Integer(row['kinopoisk']),
                       Integer(row['imdb']),
                       Integer(row['metacritic']),
                       Integer(row['rotten_tomatoes'])
                     ))
    end
    movies
  end

  def save_sorted_list(filename)
    File.open(filename, 'w+') do |row|
      @movies.each { |el| row.puts(el) }
    end
  end

  def min
    movies.min
  end

  def max
    movies.max
  end
end
