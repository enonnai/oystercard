require 'oystercard'

describe Oystercard do
  it 'a new card has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up a card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if topup exceeds limit' do
      message = "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit"
      expect { subject.top_up(Oystercard::MAX_BALANCE+1)}.to raise_error message
    end
  end

  describe '#touch_in' do
    context 'when a customer does not have min. amount for a journey' do
      before(:example) { subject.top_up(Oystercard::MIN_AMOUNT-1) }

      it 'throws an error' do
        message = "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount."
        expect {subject.touch_in}.to raise_error message
      end
    end

    context 'when a card has been topped up' do
      before(:example) {subject.top_up(Oystercard::MAX_BALANCE)}
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end

      it 'has touched in and is in a jouney' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end
  end

  describe '#touch_out' do
      before(:example) do
        subject.top_up(Oystercard::MAX_BALANCE)
        subject.touch_in
      end

      it 'has touched out and is not in a jouney' do
        subject.touch_out
        expect(subject).not_to be_in_journey
    end

    it 'charges the customer' do
      expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN_AMOUNT)
    end
  end
end
