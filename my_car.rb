class Car
    
    def initialize(mark, model,year,benz)
        @mark = mark
        @model = model
        @year = year
        @benz = benz
    end

    def to_s
        "Марка: #{mark}, Модель: #{model}, Год: #{year}, Бензин #{benz}"
    end
    
end