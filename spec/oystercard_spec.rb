require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_AMOUNT }

  it 'a new card has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up a card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if topup > limit' do
      message = "The balance exceeds the #{Oystercard::MAX_AMOUNT} pounds limit"
      expect { subject.top_up(max_balance+1)}.to raise_error message
    end
  end

  describe '#touch_in' do
    context 'when does not have min. amount for a journey' do
      before(:example) { subject.top_up(Oystercard::MIN_AMOUNT-1) }
      let(:entry_station) { entry_station = double()}

      it 'throws an error' do
        message = "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount."
        expect {subject.touch_in(entry_station)}.to raise_error message
      end
    end

    context 'when has been topped up' do
      before(:example) {subject.top_up(max_balance)}
      let(:entry_station) {entry_station = double()}
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    end

    context 'when has touched in' do
      before(:example) {subject.top_up(max_balance)}
      let(:entry_station) {entry_station = double()}
      it 'is in a jouney' do
        subject.touch_in(entry_station)
        expect(subject.in_journey?).to eq true
      end
    end
  end

  describe '#touch_out' do
    context 'when a journey is complete' do
      let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
      let(:entry_station) { station = double()}
      let(:exit_station) { station = double()}
      before(:example) do
        subject.top_up(max_balance)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end

    it 'has touched out and is not in a jouney' do
      expect(subject).not_to be_in_journey
    end

    it 'charges the customer' do
      expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_AMOUNT)
    end

    it 'stores a journey' do
      expect(subject.journeys).to include {journey}
    end
  end
end


end
