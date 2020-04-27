# frozen_string_literal: true

require_relative '../lib/obj_creator.rb'

require 'erb'

weekday = Time.now.strftime('%A')
simple_template = "Today is <%= weekday %>."

renderer = ERB.new(simple_template)
puts renderer.result()

# rc = Creator.new
# rc.create
