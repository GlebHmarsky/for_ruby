# frozen_string_literal: true

require_relative '../lib/stop.rb'

# Stops class
class Stops
  attr_reader :trainid
  def initialize
    @stops = []
  end

  def add_stop(new_stop)
    @stops.append(new_stop)
  end
end
