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

    if values[-1] == 4
      'four of a kind'
    elsif values[-1] == 3
      values[-2] == 2 ? 'full house' : 'three of a kind'
    elsif flush?
      'flush'
    elsif straight?
      'straight'
    elsif values[-1] == 2
      values[-2] == 2 ? 'two pair' : 'one pair'
    else
      'high card'
    end
  end

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