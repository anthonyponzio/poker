require 'rspec'
require 'card'

describe Card do
  context "#initialize" do
    it 'should initialize with a value and suit' do
      card_1 = Card.new(2, :D)
      expect(card_1.value).to eq(2)
      expect(card_1.suit).to eq(:D)

      card_2 = Card.new(14, :C)
      expect(card_2.value).to eq(14)
      expect(card_2.suit).to eq(:C)
    end
  end
end
