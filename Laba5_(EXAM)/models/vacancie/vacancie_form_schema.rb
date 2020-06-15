# frozen_string_literal: true

require 'dry-schema'
require_relative '../schema_types'

VacancieFormSchema = Dry::Schema.Params do
  required(:company).filled(SchemaTypes::StrippedString)
  required(:job_title).filled(SchemaTypes::StrippedString)
  required(:department).filled(SchemaTypes::StrippedString)
  required(:salary).filled(:integer, gt?: 0)

  required(:min_age).filled(:integer, gt?: 0)
  required(:max_age).filled(:integer, gt?: 0)

  required(:education).filled(SchemaTypes::StrippedString) # , format?: /^[А-Яа-я\, ]+&/)
  required(:amount).filled(:integer, gteq?: 0)
end
