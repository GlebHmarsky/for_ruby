# frozen_string_literal: true

# Movie class
class Movie
  include Comparable
  attr_reader :name
  attr_reader :r_kp
  attr_reader :r_imdb
  attr_reader :r_meta
  attr_reader :r_rt

  def initialize(name, r_kp, r_imdb, r_meta, r_rt)
    @name = name
    @r_kp = r_kp
    @r_imdb = r_imdb
    @r_meta = r_meta
    @r_rt = r_rt
  end

  def ogon_rating
    (r_imdb + r_kp + (r_meta + r_rt) / 2) / 3
  end

  def <=>(other)
    ogon_rating <=> other.ogon_rating
  end

  def to_s
    "#{@name}: #{ogon_rating}"
  end
end
