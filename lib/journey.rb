class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_CHARGE = 6
  MINIMUM_FARE = 1

  def initialize(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare(penalty)
    penalty = penalty
    penalty == false ? MINIMUM_FARE : PENALTY_CHARGE
  end

# (@exit_station.zone - @entry_station.zone).abs + 1

  def complete?
    complete = defined? @exit_station
    complete != nil
  end

end
