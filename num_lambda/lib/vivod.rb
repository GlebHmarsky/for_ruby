# frozen_string_literal: true

# Vivod class
class Vivod

  def make_table(cl)
    names = cl.hash_to_a(cl.commands_to_hash)
    printf"\t"
    for name in names do
      printf "\t #{name}"
    end
    names = cl.hash_to_a(cl.commands_to_hash)
    names.each_with_index {|name_com_one,i|
      printf "\n\n#{name_com_one}\t\t"
      names.each_with_index {|name_com_two,g|
        if g<i
          printf "#{cl.find_match(name_com_one,name_com_two)}   \t"
        elsif g==i
          printf "\t\t"
        else
          printf "#{cl.find_match(name_com_two,name_com_one)}   \t"
        end
      }
      # printf "\n\n"
    }
    printf "\n\nэтот вывод меня заебал, тут типа надо смотреть на длину слов, чтобы всё было супер пупер одинакого, но мне как-то похуй"
  end
end
