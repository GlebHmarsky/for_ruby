# frozen_string_literal: true

require 'dry-schema'

VacancieDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
