require 'journey'

describe Journey do
  let(:bank) {double :bank, name: "bank", zone: 3}
  let(:angel) {double :angel, name: "angel", zone: 1}
  subject(:journey) {described_class.new(bank)}

  it 'has an entry station' do
    expect(journey.entry_station).to eq bank
  end
  context 'after touching out' do

    before do
      journey.end_journey(angel)
    end

    it 'has an exit station' do
      expect(journey.exit_station).to eq angel
    end
  end
end
