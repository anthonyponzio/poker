class Hand
  HAND_SCORES = {
    straight_flush: 8,
    four_of_a_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_of_a_kind: 3,
    two_pair: 2,
    one_pair: 1,
    high_card: 0,
  }

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def detect_hand
    return :straight_flush if straight? && flush?

    sorted_values = values_count.values.sort
  
    case sorted_values.last
    when 4 then :four_of_a_kind
    when 3 then sorted_values[-2] == 2 ? :full_house : :three_of_a_kind
    when 2 then sorted_values[-2] == 2 ? :two_pair : :one_pair
    else
      return :flush if flush?
      return :straight if straight?
      :high_card
    end
  end

  protected
  def details
    {
      score: HAND_SCORES[detect_hand],
      ranked_values: values_count.sort_by { |key, value| [value, key] },
    }
  end

  private
  
  def values_count
    count = Hash.new(0)
    cards.each { |card| count[card.value] += 1 }
    count
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