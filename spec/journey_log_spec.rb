require 'journey_log'

describe JourneyLog do
  let(:bank) { double :bank, name: "bank", zone: 3 }
  let(:angel) { double :angel, name: "angel", zone: 1 }
  let(:journey) { double(:journey, :entry_station => bank) }
  subject(:log) { described_class.new }

  it 'should start a new journey' do
    expect(log.start(bank)).to eq log.live_journey
  end

end
