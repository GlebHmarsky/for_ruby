# frozen_string_literal: true

require_relative 'obj'
require 'csv'
# CommandList class
class ObjList
  attr_accessor :objs
  def initialize
    @objs = []
  end

  def read_data(filename)
    objs = ObjList.new
    CSV.foreach(filename, headers: false) do |row|
      @objs.append(Obj.new(
                     row[0],
                     row[1],
                     row[2]
                   ))
    end
    objs
  end

  def objs_to_hash
    new_hash = Hash.new(0)

    @objs.each do |mate|
      new_hash[mate.class_name] += 1
    end
    new_hash
  end

  def list_of_bads
    objs.each do |mate|
      printf "#{mate.class_name} - #{mate.name}: #{mate.correct_answ}\n" if mate.mark == 2
    end
  end
end
