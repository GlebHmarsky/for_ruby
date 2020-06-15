# frozen_string_literal: true

# Seeker class
Seeker = Struct.new(:id, :surname, :name, :patronymic, :birth_date, :education, :specialty, :salary, :list_companies, keyword_init: true) do
  def age
    years = Date.today.year - birth_date.year
    years += 1 if Date.today.day <= birth_date.day && Date.today.month <= birth_date.month
    years
  end

  def name_sp
    name + ' ' + surname.chars[0] + '.' + patronymic.chars[0] + '.'
  end

  def full_name
    surname + ' ' + name + ' ' + patronymic
  end
end
