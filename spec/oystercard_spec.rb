require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_AMOUNT }

  it 'a new card has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'a new card has an empty list of journeys' do
    expect(subject.journeys).to eq([{:entry_station=>" ", :exit_station=>" "}])
  end

  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up a card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if topup exceeds limit' do
      message = "The balance exceeds the #{Oystercard::MAX_AMOUNT} pounds limit"
      expect { subject.top_up(max_balance+1)}.to raise_error message
    end
  end

  describe '#touch_in' do
    context 'when a customer does not have min. amount for a journey' do
      before(:example) { subject.top_up(Oystercard::MIN_AMOUNT-1) }
      let(:entry_station) { entry_station = double()}

      it 'throws an error' do
        message = "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount."
        expect {subject.touch_in(entry_station)}.to raise_error message
      end
    end

    context 'when a card has been topped up' do
      before(:example) {subject.top_up(max_balance)}
      let(:station) { station = double()}
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end

      it 'has touched in and is in a jouney' do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it 'remembers the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end
  end

  describe '#touch_out' do
    let(:station) { station = double()}
      before(:example) do
        subject.top_up(max_balance)
        subject.touch_in(station)
        subject.touch_out(station)
      end

    it 'has touched out and is not in a jouney' do  
      expect(subject).not_to be_in_journey
    end

    it 'charges the customer' do
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-Oystercard::MIN_AMOUNT)
    end

    it 'forgets about the entry station' do
      expect(subject.entry_station).to eq nil
    end

    it 'stores the exit station'do
      expect(subject.exit_station).to eq(station)
    end

    it 'creates one journey' do
      expect(subject.journeys).to eq([{:entry_station=> station, :exit_station=> station}])
    end
  end


end
