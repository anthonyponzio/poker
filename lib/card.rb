class Card
  attr_reader :value, :suit
  
  def initialize(value, suit)
    @value, @suit = value, suit
  end

  def face
    case @value
    when 1..10 then @value.to_s
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    when 14 then 'A'
    end
  end
end