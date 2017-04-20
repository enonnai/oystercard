require 'journey'

describe Journey do

  describe '#journey_complete?' do

    context 'when not complete' do
      it 'returns false' do
        entry_station = "Bank"
        subject.start_journey(entry_station)
        expect(subject.journey_complete?).to eq false
      end
    end

    context 'when complete' do
      it 'returns true' do
        entry_station = "Bank"
        exit_station = "Borough"
        subject.start_journey(entry_station)
        subject.finish_journey(exit_station)
        expect(subject.journey_complete?).to eq true
      end
    end
  end
end
