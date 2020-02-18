require 'rspec'
require 'hand'
require 'card'

describe Hand do
  card_sets = {
    straight_flush: [
      Card.new(1, :D),
      Card.new(2, :D),
      Card.new(3, :D),
      Card.new(4, :D),
      Card.new(5, :D),
    ],
    four_of_a_kind: [
      Card.new(12, :D),
      Card.new(12, :C),
      Card.new(12, :H),
      Card.new(12, :S),
      Card.new(5, :D),
    ],
    full_house: [
      Card.new(1, :D),
      Card.new(1, :H),
      Card.new(1, :C),
      Card.new(4, :D),
      Card.new(4, :H),
    ],
    flush: [
      Card.new(1, :D),
      Card.new(8, :D),
      Card.new(3, :D),
      Card.new(4, :D),
      Card.new(5, :D),
    ],
    straight: [
      Card.new(1, :D),
      Card.new(2, :C),
      Card.new(3, :H),
      Card.new(4, :D),
      Card.new(5, :S),
    ],
    three_of_a_kind: [
      Card.new(4, :D),
      Card.new(4, :C),
      Card.new(4, :C),
      Card.new(11, :D),
      Card.new(9, :D),
    ],
    two_pair: [
      Card.new(1, :D),
      Card.new(1, :H),
      Card.new(3, :C),
      Card.new(5, :D),
      Card.new(5, :S),
    ],
    one_pair: [
      Card.new(10, :H),
      Card.new(12, :S),
      Card.new(4, :S),
      Card.new(10, :D),
      Card.new(5, :C),
    ],
    high_card: [
      Card.new(10, :H),
      Card.new(12, :S),
      Card.new(4, :S),
      Card.new(1, :D),
      Card.new(5, :C),
    ],
  }

  context '#initialize' do
    hand = Hand.new(card_sets[:straight_flush].dup)
    
    it 'should take array of 5 cards and set it to @cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  context "#beats?" do
    subject(:full_house) { Hand.new(card_sets[:full_house].dup) }

    it 'should raise error if argument is not a Hand instance' do
      expect { full_house.beats?("toaster") }.to raise_error(ArgumentError)
    end

    it 'should return true if hand beats other hand' do
      two_pair = Hand.new(card_sets[:two_pair].dup)
      flush = Hand.new(card_sets[:flush].dup)
      
      expect(full_house.beats?(two_pair)).to be true
      expect(full_house.beats?(flush)).to be true
    end

    it 'should return false if hand does not beat other hand' do
      four_of_a_kind = Hand.new(card_sets[:four_of_a_kind].dup)
      straight_flush = Hand.new(card_sets[:straight_flush].dup)

      expect(full_house.beats?(four_of_a_kind)).to be false
      expect(full_house.beats?(straight_flush)).to be false
    end
  end

  context '#discard_cards' do
    subject(:hand) { Hand.new(card_sets[:two_pair].dup)}
  
    it 'should raise error when given invalid index' do
      expect { hand.discard_cards([10]) }.to raise_error(ArgumentError)
      expect { hand.discard_cards([-1]) }.to raise_error(ArgumentError)
    end

    it 'should remove card at given index in hand' do
      card = hand.cards[0]
      hand.discard_cards([0])

      expect(hand.cards).not_to include(card)
    end

    it 'should handle multiple indexes' do
      card_1 = hand.cards[0]
      card_2 = hand.cards[1]
      card_3 = hand.cards[2]
      hand.discard_cards([0, 2, 1])

      expect(hand.cards).not_to include(card_1)
      expect(hand.cards).not_to include(card_2)
      expect(hand.cards).not_to include(card_3)
    end
  end

  context '#add_cards' do
    subject(:hand) { Hand.new(card_sets[:two_pair].dup)}

    it 'should raise error when result in more than 5 cards in hand' do
      expect { hand.add_cards([Card.new(7, :D)]) }.to raise_error(ArgumentError)
    end

    it 'should add given card to hand' do
      hand.discard_cards([0])
      
      card = Card.new(7, :D)
      hand.add_cards([card])

      expect(hand.cards).to include(card)        
    end

    it 'should add multiple cards to hand' do
      hand.discard_cards([0, 1])

      card_1 = Card.new(7, :D)
      card_2 = Card.new(11, :C)

      hand.add_cards([card_1, card_2])

      expect(hand.cards).to include(card_1)
      expect(hand.cards).to include(card_2)
    end

  end
end