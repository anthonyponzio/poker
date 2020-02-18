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
    hand = Hand.new(card_sets[:straight_flush])
    
    it 'should take array of 5 cards and set it to @cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  context '#detect_hand' do
    it 'should detect straight flush' do
      hand = Hand.new(card_sets[:straight_flush])

      expect(hand.detect_hand).to eq(:straight_flush)
    end

    it 'should detect four of a kind' do
      hand = Hand.new(card_sets[:four_of_a_kind])
      
      expect(hand.detect_hand).to eq(:four_of_a_kind)
    end

    it 'should detect full house' do
      hand = Hand.new(card_sets[:full_house])

      expect(hand.detect_hand).to eq(:full_house)
    end

    it 'should detect flush' do
      hand = Hand.new(card_sets[:flush])

      expect(hand.detect_hand).to eq(:flush)
    end

    it 'should detect straight' do
      hand = Hand.new(card_sets[:straight])

      expect(hand.detect_hand).to eq(:straight)
    end

    it 'should detect three of a kind' do
      hand = Hand.new(card_sets[:three_of_a_kind])
      
      expect(hand.detect_hand).to eq(:three_of_a_kind)
    end

    it 'should detect two pair' do
      hand = Hand.new(card_sets[:two_pair])
      
      expect(hand.detect_hand).to eq(:two_pair)
    end

    it 'should detect one pair' do
      hand = Hand.new(card_sets[:one_pair])

      expect(hand.detect_hand).to eq(:one_pair)
    end

    it 'should detect high card (no other hands)' do
      hand = Hand.new(card_sets[:high_card])

      expect(hand.detect_hand).to eq(:high_card)
    end
  end

  context "#beats?" do
    subject(:full_house) { Hand.new(card_sets[:full_house]) }

    it 'should raise error if argument is not a Hand instance' do
      expect { full_house.beats?("toaster") }.to raise_error(ArgumentError)
    end

    it 'should return true if hand beats other hand' do
      two_pair = Hand.new(card_sets[:two_pair])
      flush = Hand.new(card_sets[:flush])
      
      expect(full_house.beats?(two_pair)).to be true
      expect(full_house.beats?(flush)).to be true
    end

    it 'should return false if hand does not beat other hand' do
      four_of_a_kind = Hand.new(card_sets[:four_of_a_kind])
      straight_flush = Hand.new(card_sets[:straight_flush])

      expect(full_house.beats?(four_of_a_kind)).to be false
      expect(full_house.beats?(straight_flush)).to be false
    end
  end
end