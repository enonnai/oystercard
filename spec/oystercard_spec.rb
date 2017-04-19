require 'oystercard'

describe Oystercard do
  it 'a new card has a balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up a card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if topup exceeds limit' do
      expect { subject.top_up(Oystercard::MAX_BALANCE+1)}.to raise_error "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit"
    end
  end

  describe '#deduct' do
    before {subject.top_up(Oystercard::MAX_BALANCE)}
    it 'deducts a single journey fare from a card' do
      expect(subject.deduct).to eq(subject.balance)
    end
  end

  describe '#touch_in' do
    before(:example) {subject.top_up(Oystercard::MAX_BALANCE)}

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'has touched in and is in a jouney' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do

    it 'has touched out and is not in a jouney' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
