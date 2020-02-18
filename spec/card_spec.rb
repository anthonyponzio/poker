require 'rspec'
require 'card'

describe Card do
  context '#initialize' do
    it 'should initialize with a value and suit' do
      card_1 = Card.new(2, :D)
      expect(card_1.value).to eq(2)
      expect(card_1.suit).to eq(:D)

      card_2 = Card.new(10, :C)
      expect(card_2.value).to eq(10)
      expect(card_2.suit).to eq(:C)
    end
  end

  context '#face' do
    it 'should return the face string for the cards value' do
      card_1 = Card.new(13, :S)
      expect(card_1.face).to eq('K')
      
      card_2 = Card.new(1, :C)
      expect(card_2.face).to eq('A')
    end
  end

  context '#to_s' do
    card_1 = Card.new(12, :H)
    card_2 = Card.new(5, :C)
    
    it 'should call #face' do
      expect(card_1).to receive(:face)
      card_1.to_s

      expect(card_2).to receive(:face)
      card_2.to_s
    end

    it 'should return card face and suit in string' do
      expect(card_1.to_s).to eq('QH')
      expect(card_2.to_s).to eq('5C')
    end
  end
end
