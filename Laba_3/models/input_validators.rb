# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_date_description(raw_date, raw_description)
    date = raw_date || ''
    description = raw_description || ''
    errors = []
    errors.concat(check_date_format(date)) unless date.empty?
    {
      date: date,
      description: description,
      errors: errors
    }
  end

  def self.check_book(raw_name, raw_date, _raw_description)
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
      ['Имя книги не может быть пустым']
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
    if /\d{4}-\d{2}-\d{2}/ =~ date
      ['Дата должна существовать'] if !Date.parse(date).exist?
      []
    else
      ['Дата должна быть передана в формате ГГГГ-ММ-ДД']
    end
  end
end
