# frozen_string_literal: true

# Vac class
Vacancie = Struct.new(:id, :company, :job_title, :department, :salary, :min_age, :max_age, :education, :amount, keyword_init: true)
