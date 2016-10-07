require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

    before do
      card.top_up(Oystercard::MONEY_LIMIT)
    end

  let(:station) {double :station, name: "angel", zone: 1}
  let(:bank) {double :bank, name: "bank", zone: 3}

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  context '#top up' do

    it 'limits top up value MONEY_LIMIT' do
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context 'touching in and out' do

    it 'touching in registers a current journey' do
      card.touch_in(station)
      expect(card).to respond_to :current_journey
    end

    it 'raises error if card below minimum balance when touching in' do
      card.top_up(-Oystercard::MONEY_LIMIT)
      expect{card.touch_in(station)}.to raise_error "Insufficient funds for journey"
    end

    it 'touching out registers the card as no longer being in journey' do
      card.touch_in(station)
      card.touch_out(bank)
      expect(card.in_use).to eq false
    end

    it 'charges the card a penalty fare if you double touch in' do
      card.touch_in(station)
      expect{card.touch_in(bank)}.to change{card.balance}.by(-Journey::PENALTY_CHARGE)
    end

    it 'adds a complete journey to the journey log' do
      card.touch_in(station)
      card.touch_out(bank)
      expect(card.journey_log).to eq [[card.current_journey]]
    end
  end
end
