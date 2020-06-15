# frozen_string_literal: true

# Readed Book class
class Book
  attr_accessor :date
  attr_accessor :author
  attr_accessor :name

  def initialize(date, author, name)
    @date = date
    @author = author
    @name = name
  end

  def book_name
    "#{author} '#{name}'"
  end
end
