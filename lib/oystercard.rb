class Oystercard
  MAX_BALANCE = 90
  MIN_AMOUNT = 1

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journeys = [{:entry_station => " ", :exit_station => " "}]
  end

  def top_up(amount)
    fail "The balance exceeds the #{Oystercard::MAX_BALANCE} pounds limit" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance. £#{Oystercard::MIN_AMOUNT} is the minimum amount." if balance < MIN_AMOUNT
    @in_journey = true
    @entry_station = station
    @journeys[0][:entry_station] = @entry_station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(station)
    deduct(MIN_AMOUNT)
    @in_journey = false
    @exit_station = station
    @journeys[0][:exit_station] = @exit_station
    @entry_station = nil
  end

  private
  attr_writer :balance, :in_journey

  def deduct(amount)
    @balance -= amount
  end

end
