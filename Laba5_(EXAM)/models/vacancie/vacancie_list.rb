# frozen_string_literal: true

require_relative 'vacancie'

# The class that contains all our vacancies
class VacancieList
  def initialize(vacancies = [])
    @vacancies = vacancies.map do |vacancie|
      [vacancie.id, vacancie]
    end.to_h
  end

  def all_vacancies
    @vacancies.values
  end

  def vacancie_by_id(id)
    @vacancies[id]
  end

  def add_vacancie(parameters)
    vacancie_id = if @vacancies.empty?
                    1
                  else
                    @vacancies.keys.max + 1
                  end
    @vacancies[vacancie_id] = Vacancie.new(id: vacancie_id, **parameters.to_h)
    @vacancies[vacancie_id]
  end

  def add_real_vacancie(vacancie)
    @vacancies[vacancie.id] = vacancie
  end

  def update_vacancie(id, parameters)
    vacancie = @vacancies[id]
    parameters.to_h.each do |key, value|
      vacancie[key] = value
    end
  end

  def delete_vacancie(id)
    @vacancies.delete(id)
  end

  def unique_posts
    hash = {}
    @vacancies.values.each do |vacancie|
      f_push = false
      post_id = if hash.empty?
                  1
                else
                  hash.keys.max + 1
                end
      post = vacancie.job_title.capitalize
      if hash.nil? # full hash first time
        hash[post_id] = {}
        hash[post_id][:post_name] = post
        hash[post_id][:amount] = 0
        hash[post_id][:whoal_salary] = 0
        hash[post_id][:unique_companies] = []
        hash[post_id][:list_education] = []
      end

      hash.each do |key, value|
        if value[:post_name] == post
          f_push = true # If found sovpadenie on name 
          post_id = key
        end
      end

      next if f_push

      hash[post_id] = {}
      hash[post_id][:post_name] = post
      hash[post_id][:amount] = 1
      hash[post_id][:whoal_salary] = vacancie.salary
      hash[post_id][:unique_companies] = [].append(vacancie.company)
      hash[post_id][:list_education] = []
      vacancie.education.split(/,[ ]+/).each do |edu| # CHANGE IT, WE HAVE ONLY ONE EDUCATION!
        hash[post_id][:list_education].append(edu.strip)
      end
      hash[post_id][:unique_companies] = hash[post_id][:unique_companies].uniq
      hash[post_id][:list_education] = hash[post_id][:list_education].uniq
    end
    hash
  end

  def age_statistics(age)
    counter = 0
    sum = 0
    @vacancies.values.each do |vacancie|
      if vacancie.min_age <= age && vacancie.max_age >= age
        counter += 1
        sum += vacancie.salary
      end
    end
    return 0 if counter.zero?

    sum / counter
  end

  def job_list(seeker)
    @vacancies.select do |k, vacancie|
      next if seeker.age < vacancie.min_age ||
              seeker.age > vacancie.max_age ||
              seeker.salary > vacancies.salary ||
              seeker.education != vacancies.education
      
      f_next = false
      @seeker.list_companies.split(/,[ ]+/).each do |company|
        f_next = true if company == vacancie.company
      end
      !f_next
    end
  end
end
