# *** responsible for starting a journey -- method
# finishing a journey  -- method
# calculating the fare of a journey -- method
# returning whether or not the journey is complete. --metho / field
require './lib/oystercard'


class Journey
  attr_reader :in_journey, :journey

  def initialize(station)
    @in_journey = true
    @journey = {:entry_station => " ", :exit_station => " "}
    @journey[:entry_station] = station
  end

  def finish(station)
    @in_journey = false
    @journey[:exit_station] = station
    @journeys << @journey
    @journey = {:entry_station => " ", :exit_station => " "}
  end

  def in_journey?
    !!in_journey
  end

private

attr_writer :in_journey, :journey

end