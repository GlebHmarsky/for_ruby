# frozen_string_literal: true

require 'psych'
require_relative 'vacancie_list'
require_relative 'vacancie'

# Storage for all of our data
class VacancieStore
  attr_reader :vacancie_list

  DATA_STORE = File.expand_path('../../data/vacancies.yaml', __dir__)

  def initialize
    @vacancie_list = VacancieList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    if raw_data
      raw_data[:vacancie_list].each do |raw_vacancie|
        @vacancie_list.add_real_vacancie(Vacancie.new(**raw_vacancie))
      end
    end
  end

  def write_data
    raw_vacancies = @vacancie_list.all_vacancies.map(&:to_h)
    yaml_data = Psych.dump({
                             vacancie_list: raw_vacancies
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
