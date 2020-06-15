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
                                Book.new('2020-04-05', 'Рей Бредбери', '451 по Фаренгейту', 4, 'бумажная', ''),
                                Book.new('2019-07-22', 'Михаил Шолохов', 'Судьба человека', 3, 'бумажная', ''),
                                Book.new('2010-06-20', 'Островский', 'Гроза', 3, 'электронная', ''),
                                Book.new('2010-07-25', 'Островский', 'Снегурочка', 5, 'бумажная', ''),
                                Book.new('2020-04-05', 'Рей Бредбери', 'Марсианские хроники', 5, 'электронная', ''),
                                Book.new('2019-07-02', 'Михаил Шолохов', 'Тихий Дон', 5, 'аудио', ''),
                                Book.new('2010-06-15', "Деннис О'Нейл", 'Темный рыцарь', 10, 'бумажная', '')
                              ])

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      # 'Hello, world!'
      r.redirect('books')
    end

    r.on 'books' do
      r.is do
        @params = InputValidators.check_filter_format(r.params['format'])
        @all_books = if @params[:errors].empty?
                        opts[:books].filter(@params[:format])
                      else
                        opts[:books].all_books
                      end
        view('books')
      end

      r.on 'new' do
        r.get do
          view('new_book')
        end

        r.post do
          @params = InputValidators.check_book(r.params['date'], r.params['author'], r.params['name'],
                                               r.params['format'], r.params['value'], r.params['score'], r.params['description'])
          if @params[:errors].empty?
            opts[:books].add_book(Book.new(@params[:date], @params[:author], @params[:name],
                                           @params[:score], @params[:format], @params[:description]))
            r.redirect '/books'
          else
            view('new_book')
          end
        end
      end
    end

    r.on 'statistics' do
      r.is do
        @year_hash = opts[:books].hash
        view('statistics')
      end
      r.get String do |year|
        @year_hash = opts[:books].hash
        # pp @year_hash
        @select_year = year
        view('statistics')
      end
    end
  end
end
