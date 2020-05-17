# frozen_string_literal: true

require_relative '../lib/stop_reader.rb'
require_relative '../lib/stop.rb'
require_relative '../lib/stops.rb'

require 'tty-prompt'

def float?(str)
  Float(str)
rescue StandardError
  false
end

def main
  stop_rader = StopReader.new
  stops = stop_rader.read_stops(File.expand_path('../data/stops.csv', __dir__))
  # pp stops
  prompt = TTY::Prompt.new
  choices = [
    'Вывести расписание движения поездов',
    'Вывести список поездов, отсортировав их по количеству реальных остановок',
    'Завершить работу приложения'
  ]
  loop do
    case prompt.enum_select('Выберете действие?', choices)
    when choices[0] # raspisanie
      puts 'Сори, не успел это доделать'
      return
    when choices[1] # sorted
    # stops.stops.sort_by{ |a| a.number}
		puts 'Сори, не успел это доделать'
    when choices[2] # deadend
      return
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
