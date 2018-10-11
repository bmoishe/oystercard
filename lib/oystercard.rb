require './lib/station'

class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  attr_writer :entry_location
  attr_writer :station
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
    @station = Station.new
    @entry_location = ""
  end

  def top_up(money)
    raise "You have tried to add #{money} but the max you can add is
    #{MAXIMUM_BALANCE-@balance}" if (money > MAXIMUM_BALANCE - @balance)
    @balance += money
    balance
  end

  def balance
    @balance
  end

  def touch_in
    raise "You have no balance: Top up before using" if(@balance==0)
    raise "Journey already initiated" unless(!@in_journey)
    @in_journey = true
    @entry_location = @station.get_station
  end

  def touch_out(journey)
    raise "You have no balance: Top up before using" if(@balance==0)
    raise "Journey not initiated" unless(!@in_journey)
    @in_journey = false
    deduct(journey)
  end

  private

  def deduct(money)
    raise "Cannot deduct #{money} from #{@balance} due to in-sufficient balance" if(money > @balance)
    @balance -= money
    balance
  end
end
