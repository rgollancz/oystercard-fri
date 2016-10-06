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
    @in_use == false ? penalty_touch_out : normal_touch_out(station)
    add_journey(@current_journey)
    @in_use = false
  end

  def penalty_touch_out
    @current_journey = Journey.new('none', 'n/a')
    deduct(true)
  end

  def normal_touch_out(station)
    @current_journey.end_journey(station)
    deduct(false)
  end

  def deduct(penalty)
    penalty = penalty
    penalty == false ? charge = @current_journey.fare : charge = @current_journey.penalty
    @balance-= charge
  end

private

  def add_journey(journey)
    @history << [journey]
  end

end
