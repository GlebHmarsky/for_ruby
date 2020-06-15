# frozen_string_literal: true

require 'psych'
require_relative 'seeker_list'
require_relative 'seeker'

# Storage for all of our data
class SeekerStore
  attr_reader :seeker_list

  DATA_STORE = File.expand_path('../../data/seekers.yaml', __dir__)

  def initialize
    @seeker_list = SeekerList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:seeker_list].each do |raw_seeker|
      @seeker_list.add_real_seeker(Seeker.new(**raw_seeker))
    end
  end

  def write_data
    raw_seekers = @seeker_list.all_seekers.map(&:to_h)
    yaml_data = Psych.dump({
                             seeker_list: raw_seekers
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
