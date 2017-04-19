class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance, :in_journey

  def initialize
    self.balance = 0
  end

  def top_up(amount)
    fail "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit" if self.balance + amount > MAX_BALANCE
    self.balance += amount
  end

  def deduct()
    self.balance -= 1
  end

  def touch_in
    self.in_journey = true
  end

  def in_journey?
    !!in_journey
  end

  def touch_out
    self.in_journey = false
  end

  private
  attr_writer :balance, :in_journey

end
