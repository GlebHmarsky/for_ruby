# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'

SeekerFormSchema = Dry::Schema.Params do
  required(:surname).filled(SchemaTypes::StrippedString)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:patronymic).maybe(SchemaTypes::StrippedString) # Отчество бывает не у всех!
  required(:birth_date).filled(:date)
  required(:education).filled(SchemaTypes::StrippedString)
  required(:specialty).filled(SchemaTypes::StrippedString)
  required(:salary).filled(:integer)
  required(:list_companies).maybe(SchemaTypes::StrippedString) # Список нежелательных может быть и пустым!
end
