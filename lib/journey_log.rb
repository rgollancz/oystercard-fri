class JourneyLog

  attr_reader :entry_station, :past_journeys
  attr_accessor :live_journey

  def initialize
    @live_journey = nil
    @past_journeys = []
  end

  def start(station)
    @live_journey = Journey.new(station)
  end

  def finish(station)
    @live_journey = current_journey
    @live_journey.set_end_station(station)
    add_journey
  end

  private

  def add_journey
    @past_journeys << @live_journey
  end

  def current_journey
    @live_journey == nil ? @live_journey = Journey.new(nil) : @live_journey
  end

end
