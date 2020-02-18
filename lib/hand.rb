class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def detect_hand
    return 'straight flush' if straight? && flush?

    count = Hash.new(0)
    cards.each { |card| count[card.value] += 1 }
    values = count.values.sort
  
    case values.last
    when 4 then 'four of a kind'
    when 3 then values[-2] == 2 ? 'full house' : 'three of a kind'
    when 2 then values[-2] == 2 ? 'two pair' : 'one pair'
    else
      return 'flush' if flush?
      return 'straight' if straight?
      'high card'
    end
  end

  private
  def flush?
    cards.all? { |card| cards[0].suit == card.suit }
  end

  def straight?
    sorted_cards = cards.sort_by { |card| card.value }

    (0..3).to_a.all? do |i|
      card_1 = sorted_cards[i]
      card_2 = sorted_cards[i + 1]
      card_1.value + 1 == card_2.value
    end
  end
end