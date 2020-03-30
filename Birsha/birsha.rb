
def float?(str)
    Float(str) rescue false
end
if(ARGV.size ==0 )
    printf "Приложение эмитирует игру на рынке. Передайте стартовый капитал и количество дней в качестве аргументов приложения.
    
birsha.rb CAPITAL DAYS"
    return
elsif ARGV.size == 1
    printf "НЕ ДОСТАТОЧНО АРГУМЕЕЕЕНТОВ!"
    return
elsif ARGV.size > 2
    printf "многовато аргументов!"
end 

c = ARGV[0]
if(!volume=float?(c)) then
    p "Ругаться!1"
else 
    printf "Start invests: #{volume}\n"
end

c = ARGV[1]
if(!days=float?(c)) then
    p "Ругаться!2"
else 
    printf "Days: #{days.to_i}\n"
end

days.to_i.times do
    rnd = rand(16)
    if rnd > 14
        volume *= 1.1
    elsif rnd > 12
        volume *= 1.02
    elsif rnd > 9
        volume *= 1
    elsif rnd > 7
        volume *= 0.98
    elsif rnd >5
        volume *= 0.9
    else 
        volume *=0.5
    end
    printf "#{rnd} #{volume} \n"
end