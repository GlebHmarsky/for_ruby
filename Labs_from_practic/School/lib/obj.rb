# frozen_string_literal: true

#  class
class Obj
  attr_reader :class_name
  attr_reader :name
  attr_reader :whoal_score

  def initialize(class_name, name, whoal_score)
    @class_name = class_name
    @name = name
    @whoal_score = whoal_score
  end

  def mark
    count_one = correct_answ
    if count_one >= 31
      5
    elsif count_one >= 26
      4
    elsif count_one >= 21
      3
    else
      2
    end
  end

  def correct_answ
    count_one = 0
    whoal_score.chars.each do |i|
      count_one += 1 if i == '1'
    end
    count_one
  end
end
