# frozen_string_literal: true

require_relative 'comman_list'
require_relative 'vivod'

require 'optparse'
require 'pathname'

# RC class
class RatingCreator
  def create
    pn = Pathname.new(File.expand_path('../data/2019-ti-group-stage.csv', __dir__))
    unless pn.exist?
      puts 'Нет такого файла!'
      nil
    end
    cl = CommandList.new
    cl.read_data pn.to_path
    # t = cl.commands_to_hash
    # tt = cl.hash_to_a(t)
    # tmp = -> (name) do
    #   pp name.next
    # end
    # loop do
    #   tmp.call tt
    # end

    # cl.hash_sort_by_score(t) do |tmp|
    #   pp tmp
    # end

    # pp t = cl.add(Command.new("hi","mark",1,0))
    vi = Vivod.new
    vi.make_table(cl)
  end
end
