# frozen_string_literal: true

require_relative 'obj_list'

require 'pathname'
require 'tty-prompt'
# require 'optparse'

# C class
class Creator
  def initialize
    @prompt = TTY::Prompt.new
    @obj_list = ObjList.new
  end
  MENU_CHOISES = [
    { name: 'Вывести список двоечников', value: :dva },
    { name: 'Вычислять статистику тестирования', value: :static },
    { name: 'Вывести список сложных вопросов', value: :sloshno },
    { name: 'Завершить работу приложения', value: :exit }
  ].freeze

  def create
    @prompt = TTY::Prompt.new
    pn = Pathname.new(File.expand_path('../data/test_results.csv', __dir__))
    unless pn.exist?
      puts 'Нет такого файла!'
      nil
    end
    @obj_list.read_data pn.to_path
    show_menu
  end

  def show_menu
    loop do
      action = @prompt.select('Выберите действие', MENU_CHOISES)
      break if action == :exit

      show_dva if action == :dva
      show_sloshno if action == :sloshno
      show_static if action == :static
    end
  end

  def show_dva
    @obj_list.list_of_bads
  end

  def show_static
    new_hash = Hash.new(0)
    new_hash_mark = Hash.new(0)
    @obj_list.objs.each do |mate|
      new_hash_mark[mate.class_name] += mate.correct_answ
      new_hash[mate.class_name] += 1
    end
    arr = new_hash.to_a
    arr_mark = new_hash_mark.to_a
    arr.each_index do |i|
      printf "#{arr[i][0]}: #{arr_mark[i][1].to_f / arr[i][1]}\n"
    end
  end

  def show_sloshno
    new_hash = Hash.new(0)
    @obj_list.objs.each do |mate|
      arr = mate.whoal_score.chars
      arr.each_index do |i|
        new_hash[i] += Integer(arr[i])
      end
    end
    printf "3 самых малорешнных вопроса\n"
    new_hash.to_a.sort { |a, b| a[1] <=> b[1] }.first(3).each do |i|
      printf "№#{i[0]}: #{i[1]}\n"
    end
  end
end
