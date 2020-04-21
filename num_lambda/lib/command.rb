# frozen_string_literal: true

# Commands class
class Command
  attr_reader :com_one
  attr_reader :com_two
  attr_reader :score_one
  attr_reader :score_two

  def initialize(com_one, com_two, score_one, score_two)
    @com_one = com_one
    @com_two = com_two
    @score_one = score_one
    @score_two = score_two
  end
end
