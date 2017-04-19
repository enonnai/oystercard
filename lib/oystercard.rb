class Oystercard
  MAX_BALANCE = 90
  MIN_AMOUNT = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    fail "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount." if balance < MIN_AMOUNT
    @in_journey = true
  end

  def in_journey?
    !!in_journey
  end

  def touch_out
    deduct(MIN_AMOUNT)
    @in_journey = false
  end

  private
  attr_writer :balance, :in_journey

  def deduct(amount)
    @balance -= amount
  end

end
