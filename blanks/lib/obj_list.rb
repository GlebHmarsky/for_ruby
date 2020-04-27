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
    CSV.foreach(filename, headers: true) do |row|
      @objs.append(Obj.new(
                     row[0],
                     row[1],
                     Integer(row[2]),
                     Integer(row[3])
                   ))
    end
    objs
  end
end
