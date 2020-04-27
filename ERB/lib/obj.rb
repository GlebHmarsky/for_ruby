# frozen_string_literal: true

#  class
class Obj
  attr_reader :com_one
  attr_reader :com_two
  attr_reader :score_one
  attr_reader :score_two

  def initialize(com_one, _com_two, _score_one, _score_two)
    @com_one = com_one
    # @com_two = com_two
    # @score_one = score_one
    # @score_two = score_two
  end
end
