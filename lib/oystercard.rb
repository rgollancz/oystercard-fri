require_relative 'station'
require_relative 'journey'
class Oystercard

  attr_reader :balance, :history, :current_journey, :in_use

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    deduct(true) if @in_use == true
    @current_journey = Journey.new(station)
    @in_use = true
  end

  def touch_out(station)
    finish_journey(station)
    add_journey(@current_journey)
  end

  def finish_journey(station)
    (@current_journey = Journey.new(nil)) && deduct(true) unless @in_use
    @current_journey.end_journey(station)
    deduct(false)
    @in_use = false
  end

  def deduct(penalty)
    charge = @current_journey.fare(penalty)
    @balance-= charge
  end

private

  def add_journey(journey)
    @history << [journey]
  end

end
