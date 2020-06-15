# frozen_string_literal: true

require_relative 'seeker'

# The class that contains all our seekers
class SeekerList
  def initialize(seekers = [])
    @seekers = seekers.map do |seeker|
      [seeker.id, seeker]
    end.to_h
  end

  def all_seekers
    @seekers.values
  end

  def seeker_by_id(id)
    @seekers[id]
  end

  def add_seeker(parameters)
    seeker_id = if @seekers.empty?
                  1
                else
                  @seekers.keys.max + 1
                end
    @seekers[seeker_id] = Seeker.new(id: seeker_id, **parameters.to_h)
    @seekers[seeker_id]
  end

  def add_real_seeker(seeker)
    @seekers[seeker.id] = seeker
  end

  def update_seeker(id, parameters)
    seeker = @seekers[id]
    parameters.to_h.each do |key, value|
      seeker[key] = value
    end
  end

  def delete_seeker(id)
    @seekers.delete(id)
  end

  def age_statistics(age) # Диапазон в 5 лет +3 -2
    counter = 0
    sum = 0
    @seekers.values.each do |seeker|
      if seeker.age - 2 <= age && seeker.age + 3 >= age
        counter += 1
        sum += seeker.salary
      end
    end
    return 0 if counter == 0

    sum / counter
  end
end
