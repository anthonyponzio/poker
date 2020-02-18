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

  def beats?(other_hand)
    unless other_hand.is_a?(Hand)
      raise ArgumentError.new('argument must be instance of Hand')
    end

    case score <=> other_hand.score
    when -1 then return false # our score is less than other hand score
    when 1 then return true   # our score is greater than other hand score
    else                      # our score is the same as other hand score, compare ranked values
      other_hand_ranked_values = other_hand.ranked_values
      
      ranked_values.each_with_index do |value, i|
        case value <=> other_hand_ranked_values[i]
        when -1 then return false
        when 1 then return true
        end
      end
      
      false # our hand doesn't beat other_hand
    end
  end

  protected
  def score
    HAND_SCORES[detect_hand]
  end

  def ranked_values
    sorted_values_count = values_count.sort_by { |card_value, count| [count, card_value] }
    sorted_values_count.map { |(card_value, count)| card_value }.reverse
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