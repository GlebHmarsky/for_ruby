# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_book(raw_date, raw_author, raw_name)
    date = raw_date || ''
    author = raw_author || ''
    name = raw_name || ''
    errors = [].concat(check_date(date))
               .concat(check_name(name))
               .concat(check_author(author))
               .concat(check_date_format(date))
    {
      name: name,
      date: date,
      author: author,
      errors: errors
    }
  end

  def self.check_name(name)
    if name.empty?
      ['Название книги не может быть пустым']
    else
      []
    end
  end

  def self.check_author(author)
    if author.empty?
      ['Имя автора не может быть пустым']
    else
      []
    end
  end

  def self.check_date(date)
    if date.empty?
      ['Дата не может быть пустой']
    else
      []
    end
  end

  def self.check_date_format(date)
    if (/\d{4}-\d{2}-\d{2}/ =~ date) 
      split_date = date.split('-')
      if Date.valid_date?(split_date[0].to_i, split_date[1].to_i, split_date[2].to_i)
        if Date.today < Date.parse(date)
          return ['Указанная дата находится в будущем'] 
        end
      else
        return ['Дата должна существовать'] 
      end
    else
      return['Дата должна быть передана в формате ГГГГ-ММ-ДД'] 
    end
    []
  end
end
