# frozen_string_literal: true

# Readed Book class
class Book
  attr_accessor :date
  attr_accessor :author
  attr_accessor :name
  attr_accessor :score
  attr_accessor :format
  attr_accessor :description

  def initialize(date, author, name, score, format, description)
    @date = date
    @author = author
    @name = name
    @score = score
    @format = format
    @description = description
  end

  def book_name
    "#{author} '#{name}'"
  end
end
