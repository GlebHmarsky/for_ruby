# frozen_string_literal: true

# Stop class
class Stop
  attr_reader :trainid
  attr_reader :number
  attr_reader :station_code
  attr_reader :arrival_time
  attr_reader :stop_duration
  attr_reader :distance

  def initialize(trainid, number, station_code, arrival_time, stop_duration, distance)
    @trainid = trainid
    @number = number
    @station_code = station_code
    @arrival_time = arrival_time
    @stop_duration = stop_duration
    @distance = distance
  end

  def to_s
    "#{_trainid}: #{station_code}(#{arrival_time})\t#{stop_duration}(#{distance})"
  end
end
