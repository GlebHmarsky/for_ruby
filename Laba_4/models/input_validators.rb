# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_filter_format(raw_format)
    format = raw_format || ''
    errors = []
    errors.concat(check_format(format)) unless format.empty?
    {
      format: format,
      errors: errors
    }
  end

  def self.check_book(raw_date, raw_author, raw_name,
                      raw_format, raw_value, raw_score, raw_description)
    date = raw_date || ''
    author = raw_author || ''
    name = raw_name || ''
    format = raw_format || ''
    value = raw_value || ''
    score = raw_score || ''
    description = raw_description || ''
    errors = [].concat(check_date(date))
               .concat(check_name(name))
               .concat(check_author(author))
               .concat(check_date_format(date))
               .concat(check_format(format))
               .concat(check_value(value))
               .concat(check_score(score))
               .concat(check_description(description))
    {
      name: name,
      date: date,
      author: author,
      format: format,
      value: value,
      score: score,
      description: description,

      errors: errors
    }
  end

  def self.check_format(format)
    if format.empty?
      ['Формат не может быть пустым']
    else
      format = format.downcase
      return ['Формат не является стандартным'] if format != 'бумажная' && format != 'электронная' && format != 'аудио'

      []
    end
  end

  def self.check_score(score)
    if score.strip.empty?
      ['Оценка книги не может быть пустой']
    else
      return ['Оценка книги должна быть в пределах от 0 до 10'] if Integer(score) > 10 || Integer(score).negative?

      []
    end
  end

  def self.check_value(value)
    if value.strip.empty?
      ['Объём книги не может быть пустым']
    else
      []
    end
  end

  def self.check_description(description)
    if description.strip.chars.size > 2000
      ['Описание не должно содержать более 2000 символов']
    else
      []
    end
  end

  def self.check_name(name)
    if name.strip.empty?
      ['Название книги не может быть пустым']
    else
      []
    end
  end

  def self.check_author(author)
    if author.strip.empty?
      ['Имя автора не может быть пустым']
    else
      []
    end
  end

  def self.check_date(date)
    if date.strip.empty?
      ['Дата не может быть пустой']
    else
      []
    end
  end

  def self.check_date_format(date)
    return ['Дата должна быть передана в формате ГГГГ-ММ-ДД'] unless /\d{4}-\d{2}-\d{2}/ =~ date

    split_date = date.split('-')
    unless Date.valid_date?(split_date[0].to_i, split_date[1].to_i, split_date[2].to_i)
      return ['Дата должна существовать']
    end
    return ['Указанная дата находится в будущем'] if Date.today < Date.parse(date)

    []
  end
end
