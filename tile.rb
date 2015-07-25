require 'colorize'

class Tile
  attr_accessor :value, :given

  def initialize(value=0)
    @value = value
    @given = value != 0
  end

  def to_s
    given ? value.colorize(:red) : value
  end
end
