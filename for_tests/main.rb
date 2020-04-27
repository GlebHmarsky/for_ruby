# frozen_string_literal: false

def float?(str)
  Float(str)
rescue 
  false
end

def main
  if ![1,3,5].filter!{|n|n.even?}.empty?
    pp "hi"
  else 
    pp 'goodbye'
  end
end

main if __FILE__ == $PROGRAM_NAME
