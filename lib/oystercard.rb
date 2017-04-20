require './lib/journey'

class Oystercard
  MAX_AMOUNT = 90
  MIN_AMOUNT = 1

  attr_reader :balance, :in_journey, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "The balance exceeds the #{Oystercard::MAX_AMOUNT} pounds limit" if balance + amount > MAX_AMOUNT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount." if balance < MIN_AMOUNT
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_AMOUNT)
    @journey.finish(station)
    reset_journey
  end

  private
  attr_writer :balance, :in_journey

  def reset_journey
    @in_journey = false
  end

  def deduct(amount)
    @balance -= amount
  end

end
