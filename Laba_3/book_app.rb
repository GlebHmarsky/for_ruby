# frozen_string_literal: true

require 'roda'
require_relative 'models'

# The core class of the web application for managing books
class BookApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:books] = BookList.new([
                                Book.new('2020-04-05', 'Рей Бредбери', '451 по Фаренгейту'),
                                Book.new('2019-07-20', 'Михаил Шолохов', 'Тихий Дон'),
                                Book.new('2020-06-20', 'Островский', 'Гроза'),
                                Book.new('2020-06-20', 'Островский', 'Гроза'),
                                Book.new('2020-04-05', 'Рей Бредбери', '451 по Фаренгейту'),
                                Book.new('2019-07-20', 'Михаил Шолохов', 'Тихий Дон')
                              ])

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      'Hello, world!'
    end

    r.on 'books' do
      r.is do
        @all_books = opts[:books].all_books
        view('books')
      end

      r.on 'new' do
        r.get do
          view('new_book')
        end

        r.post do
          @params = InputValidators.check_book(r.params['name'], r.params['date'], r.params['description'])
          if @params[:errors].empty?
            opts[:books].add_book(book.new(@params[:name], @params[:date], @params[:description]))
            r.redirect '/books'
          else
            view('new_book')
          end
        end
      end
    end
  end
end
