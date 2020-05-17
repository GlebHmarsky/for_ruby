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

  def all_books
    @books.sort { |a, b| Date.parse(a.date) <=> Date.parse(b.date) }.reverse.dup
  end

  def filter(date, name)
    @books.select do |book|
      next if !date.empty? && date != book.date
      next if !name.empty? && !book.name.include?(name)

      true
    end
  end
end
