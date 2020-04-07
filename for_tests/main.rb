# frozen_string_literal: false

def float?(str)
  Float(str)
rescue 
  false
end

def main
  printf "Це калькуль, давай учиться считать вместе\n>"

  num = sum = 0
  while !num.nil? && num
    if !(num = float?(gets))
      next
    end

    pp num
    sum += num
    pp sum
  end
end

main if __FILE__ == $PROGRAM_NAME
