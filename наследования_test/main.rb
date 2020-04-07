class Parent1
    def to_s
        "Par1 class"
    end
end

class Parent2
    def to_s
        "Par2 class"
    end
end

class Child < Parent1
end

Child child = Child.new
puts child