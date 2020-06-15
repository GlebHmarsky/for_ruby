# frozen_string_literal: true

require 'forwardable'
require 'date'

# The list of books to manage
class BookList
  extend Forwardable
  def_delegator :@books, :each, :each_book

  def initialize(books = [])
    @books = books
  end

  def add_book(book)
    @books.append(book)
  end

  def hash
    years_hash = {}
    @books.each do |book|
      cur_year = Date.parse(book.date).year
      cur_month = Date.parse(book.date).month

      if years_hash[cur_year].nil?
        month_hash = {}
        years_hash[cur_year] = month_hash
      end
      if years_hash[cur_year][cur_month].nil?
        years_hash[cur_year][cur_month] = [].append(book) if book.format == 'бумажная'
      else
        years_hash[cur_year][cur_month].append(book) if book.format == 'бумажная'
      end
    end
    years_hash
  end

  def all_books
    @books.sort { |a, b| Date.parse(a.date) <=> Date.parse(b.date) }.reverse.dup
  end

  def filter(format)
    @books.select do |book|
      next if !format.empty? && format != book.format

      true
    end
  end
end
