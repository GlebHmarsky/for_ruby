# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_age(parameters)
    if !parameters[:min_age].nil? && !parameters[:max_age].nil?
      if parameters[:min_age] > parameters[:max_age]
        return errors = ['Минимальный возраст не может быть больше максимального']
      end
    end
    errors = []
  end

  def self.check_input_age(age)
    errors = []
    if age.nil?
      return {
        age: age,
        errors: errors
      }
    end
    if age.strip.empty?
      return { errors: errors.append('Возраст не может быть пустым') }
    else
      begin
        cur_age = Integer(age)
      rescue StandardError
        return { errors: errors.append('Возраст должен быть натуральным числом') }
      end
      return { errors: errors.append('Возраст должен быть натуральным числом') } unless cur_age > 0
    end

    {
      age: cur_age,
      errors: errors
    }
  end
end
