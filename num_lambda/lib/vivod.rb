# frozen_string_literal: true

# Vivod class
class Vivod
  def initialize
    
  end
  def make_table(cl)

    names = cl.hash_to_a(cl.commands_to_hash)
    for name in names do
      printf "\t\t#{name}"
    end
    names = cl.hash_to_a(cl.commands_to_hash)
    for i in names.size do
      
    end
  end
end
