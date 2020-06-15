# frozen_string_literal: true

require 'dry-schema'

SeekerDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
