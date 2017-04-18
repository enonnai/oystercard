require 'oystercard'

describe Oystercard do
  it 'checks that a new card has a balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up a card\'s balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error' do
      expect { subject.top_up(Oystercard::MAX_BALANCE+1)}.to raise_error "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit"
    end
  end

  describe '#deduct' do
    #it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'deducts a single journey fare from a card' do
      subject.top_up(10)
      deduction = 2.50
      expect(subject.deduct).to eq(subject.balance)
    end
  end

end
