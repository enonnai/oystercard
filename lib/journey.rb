# calculating the fare of a journey -- method
require './lib/oystercard'

class Journey

  def initialize
    @journey = {}
  end

  def start_journey(station)
    @journey[:entry_station] = station
  end

  def finish_journey(station)
    @journey[:exit_station] = station
  end

  def journey_complete?
    @journey.has_key?(:exit_station)
  end


private

attr_writer :journey

end
