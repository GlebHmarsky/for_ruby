def float?(str)
    Float(str) rescue false
end

if ARGV.size == 0
    printf "Приложение подбирает работу для вас на основании введённых данных\n\nfind_job.rb --name=NAME --surname=SURNAME --mail=MAIL --age=AGE --experience=EXPERIENCE"
    return
elsif ARGV.size < 5 && ARGV.size > 1
    printf "НЕДОСТАТОЧНО АРГУМЕЕЕЕНТОВ!"
    return
elsif ARGV.size > 5
    printf "многовато аргументов!"
    return
end 

if ARGV.size == 1
   if(ARGV[0].downcase == "--help")
	printf "Ты глупый или как?\nтут типа справка, для тебя, видимо"
   else 
	printf "Плохой аргумент!"
   end
   return
end

for i in 0..4 do

	if(ARGV[i].downcase.include? "--name")
		(index = ARGV[i].index "=")
		if(NAME = ARGV[i][index+1..ARGV[i].length] ).empty?
			printf"Пустое имя!"
			return
		end
	end

	if(ARGV[i].downcase.include? "--surname")
		index = ARGV[i].index "="
		if(SURNAME = ARGV[i][index+1..ARGV[i].length]).empty?
			printf"Пустая фамилия!"
			return
		end
		
	end

	if(ARGV[i].downcase.include? "--mail")
		index = ARGV[i].index "="
		if(MAIL = ARGV[i][index+1..ARGV[i].length]).empty?
			printf"Пустая почта!"
			return
		else
			if !MAIL.match?(/[a-zA-Z0-9._]+@[a-zA-Z]+.[a-zA-Z]+/)
				printf"Плохая почта!"
				return
			end
		end
	end

	if(ARGV[i].downcase.include? "--age")
		index = ARGV[i].index "="
		if(age = ARGV[i][index+1..ARGV[i].length]).empty?
			printf"Вы вне времени!?"
			return
		end
		if !(AGE = float?(age))
			printf"Лучше цифрами укзывать возраст."
			return
		elsif AGE < 15
			printf"Вы младше 15 лет, так не пойдёт!"
			return
		end
	end

	if(ARGV[i].downcase.include? "--experience")
		index = ARGV[i].index "="
		if(experience = ARGV[i][index+1..ARGV[i].length]).empty?
			printf"0 - это тоже опыт!"
			return
		end
		if !(EXPERIENCE = float?(experience))
			printf"Лучше цифрами укзывать опыт."
			return
		end
	end

end

if(EXPERIENCE > AGE - 15)
	printf"Что-то не так с вашим опытом работы."
	return
end
prof = ""
if (NAME == "Пётр".downcase && SURNAME == "Петрович")
	prof = "Руководитель"
elsif MAIL.include? "code"
	prof = "Инженер"
elsif EXPERIENCE < 2
	prof = "Стажёр"
elsif AGE <=60 && AGE >= 45
	prof = "Бывалый"
end

if EXPERIENCE > 15
	prof<<" Заслуженный"
elsif EXPERIENCE > 5
	prof<<" Известный"
end

if !prof.empty?
	printf "Ваша рекомендуемая профессия: #{prof}"
else
	printf "Сегодня без рекомендаций :("
end