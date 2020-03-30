# frozen_string_literal: true

require 'tty-prompt'

def float?(str)
  Float(str)
rescue StandardError
  false
end

def parse_to_i(string_array)
  # arr = []
  # string_array.each do |ss|
  #     arr.append(ss.split(" ").map(&:to_i))
  # end
  # return arr
  string_array.split(' ').map(&:to_i)
end

def read_from_file(filename)
  file = File.open(filename)
  arr = file.read.split(' ').map(&:to_i)
  file.close
  arr
end

def read_from_stream
  # prompt = TTY::Prompt.new
  # string_array = prompt.multiline("Enter array: ")
  puts 'Enter array: '
  string_array = gets
  parse_to_i(string_array)
end

def count_sign_for(array)
  counter = 0
  fSigh = 0
  array_of_switches = []
  array.each do |i|
    if i < 0 && fSigh == 0
      array_of_switches.push array.index i
      counter += 1
      fSigh = 1
    elsif i >= 0 && fSigh == 1
      fSigh = 0
      array_of_switches.push array.index i
      counter += 1
    end
  end
  array_of_switches.unshift counter
end

def count_sign_interator(array)
  counter = 0
  fSigh = 0
  array_of_switches = []
  array.each do |i|
    if i < 0 && fSigh == 0
      array_of_switches.push array.index i
      counter += 1
      fSigh = 1
    elsif i >= 0 && fSigh == 1
      fSigh = 0
      array_of_switches.push array.index i
      counter += 1
    end
  end
  array_of_switches.unshift counter
end

def index_of_2_loop(array)
  puts array[0]
  i = 1
  while i < array.size
    puts array[i]
    i *= 2
  end
end

def index_of_2_ind(array)
  array.each_with_index do |var, index|
    printf var if index.even?
  end
end

def polynom_of_ind(array); end

def main
  if ARGV.empty?
    printf("Приложение работает с массивом целых чисел. Вы можете ввести массив прямо из консоли или задать файл в параметрах

main.rb filename.txt\n")
    array_of_int = read_from_stream
  elsif ARGV.size == 1
    array_of_int = read_from_file(ARGV[0])
  elsif ARGV.size > 1
    printf('Много аргументов')
  end
  puts 'Полученный массив'
  pp array_of_int
  printf "Первое значение кол-во смен знака, остальные - позиции смены знака\n"

  array_1 = count_sign_for(array_of_int)
  pp array_1

  array_2 = count_sign_interator(array_of_int)
  pp array_2

  # index_of_2_loop(array_of_int)
end

main if __FILE__ == $PROGRAM_NAME
