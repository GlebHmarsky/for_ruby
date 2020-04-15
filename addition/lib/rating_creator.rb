# frozen_string_literal: true

require_relative 'movie_list'

require 'optparse'
require 'pathname'

# RC class
class RatingCreator
  def create
    if ARGV.size != 2
      puts 'Мало аргументов!!'
      return
    end
    pn = Pathname.new(File.expand_path('../data/input.csv', __dir__))
    unless pn.exist?
      puts 'Нет такого файла!'
      nil
    end
    ml = MovieList.new
    ml.read_data pn.to_path
    pp ml.movies
    ml.movies = ml.movies.sort
    puts ml.movies
  end
end
