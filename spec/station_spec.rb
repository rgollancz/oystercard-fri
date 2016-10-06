require 'station'

describe Station do
subject(:angel) { described_class.new("Angel",1) }
subject(:bank) { described_class.new("Bank",3) }

  context 'initialization' do

    it 'a new station has a name' do
      expect(angel.name).to eq "Angel"
    end

    it 'a new station has a zone' do
      expect(angel.zone).to eq 1
    end


  end


end
