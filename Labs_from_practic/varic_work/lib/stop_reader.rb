# frozen_string_literal: true

require_relative 'stop.rb'
require_relative 'stops.rb'

require 'csv'

# StopReader class
class StopReader
  def read_stops(filename)
    stops = Stops.new
    CSV.foreach(filename, headers: true) do |row|
      stops.add_stop(Stop.new(
                       Integer(row['TRAINID']),
                       Integer(row['NUMBER']),
                       Integer(row['STATION_CODE']),
                       row['ARRIVAL_TIME'],
                       Integer(row['STOP_DURATION']),
                       Integer(row['DISTANCE'])
                     ))
    end
    stops
  end
end
