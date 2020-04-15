# frozen_string_literal: true

require_relative 'movie'
require 'csv'
# MovieList class
class MovieList
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
end
