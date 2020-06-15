# frozen_string_literal: false

require_relative 'book'
require 'date'
def float?(str)
  Float(str)
rescue 
  false
end
@books = [Book.new('2020-04-05', 'Рей Бредбери', '451 по Фаренгейту'),
  Book.new('2019-07-20', 'Михаил Шолохов', 'Тихий Дон'),
  Book.new('2020-06-20', 'Островский', 'Гроза'),
  Book.new('2020-06-20', 'Островский', 'Гроза'),
  Book.new('2020-04-05', 'Рей Бредбери', '451 по Фаренгейту'),
  Book.new('2019-07-20', 'Михаил Шолохов', 'Тихий Дон')
]
def all_books
  @books.sort{|a,b| Date.parse(a.date) <=> Date.parse(b.date)}.reverse.dup
end

def get_hash
  years_hash = Hash.new()
  @books.each do |book|

    cur_year = Date.parse(book.date).year
    cur_month = Date.parse(book.date).month

    if(years_hash[cur_year] == nil)
      month_hash = Hash.new()
      years_hash[cur_year] = month_hash
    end
    if( years_hash[cur_year][cur_month].nil? )
      years_hash[cur_year][cur_month]=[].append(book)     
    else
      years_hash[cur_year][cur_month].append(book)
    end
  end
  years_hash
end



def main
  # pp Date.parse'2019-07-20'.valid_encoding?
  # pp @books
  
    
  pp get_hash
  var = Date.valid_date?('2020','17','1') 
  pp var
   
  # (2021,07,20)
end

main if __FILE__ == $PROGRAM_NAME
