require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'
class Oystercard

  attr_reader :balance, :journey_log

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new()
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    deduct(true) if @journey_log.live_journey != nil
    @journey_log.start(station)
  end

  def touch_out(station)
    deduct(true) if @journey_log.live_journey == nil
    @journey_log.finish(station)
    deduct(false)
  end

  def deduct(penalty)
    journey = @journey_log.live_journey
    charge = journey.fare(penalty)
    @balance-= charge
    reset_journey
  end

  def reset_journey
    @journey_log.live_journey = nil
  end

end
