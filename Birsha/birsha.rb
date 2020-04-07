# frozen_string_literal: true

def float?(str)
  Float(str)
rescue StandardError
  false
end
if ARGV.empty?
  printf "Приложение эмитирует игру на рынке. Передайте стартовый капитал
   и количество дней в качестве аргументов приложения.

birsha.rb CAPITAL DAYS"
  return
elsif ARGV.size == 1
  printf 'НЕ ДОСТАТОЧНО АРГУМЕЕЕЕНТОВ!'
  return
elsif ARGV.size > 2
  printf 'многовато аргументов!'
end

c = ARGV[0]
if !volume = float?(c)
  p 'Ругаться!1'
else
  printf "Start invests: #{volume}\n"
end

c = ARGV[1]
if !days = float?(c)
  p 'Ругаться!2'
else
  printf "Days: #{days.to_i}\n"
end

days.to_i.times do
  rnd = rand(16)
  volume *= if rnd > 14
              1.1
            elsif rnd > 12
              1.02
            elsif rnd > 9
              1
            elsif rnd > 7
              0.98
            elsif rnd > 5
              0.9
            else
              0.5
            end
  printf "#{rnd} #{volume} \n"
end
