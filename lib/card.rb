class Card
  attr_reader :value, :suit
  
  def initialize(value, suit)
    @value, @suit = value, suit
  end

  def face
    case @value
    when 1 then 'A'
    when 2..10 then @value.to_s
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    end
  end

  def to_s
    "#{face}#{suit}"
  end
end