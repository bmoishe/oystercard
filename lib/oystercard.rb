<<<<<<< HEAD
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
=======
class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  attr_reader :balance, :status, :starting_station, :exit_station, :journey, :journey_list, :station_zone, :station

  def initialize
    @balance = 0
    @status = false
    @starting_station = nil
    @exit_station = nil
    @journey = Hash.new
    @journey_list = []
    @station_zone = ""
    @station = Station.new
  end

  def top_up(value)
    fail "Max balance of #{ MAX_BALANCE }." unless(@balance + value) <= MAX_BALANCE
    @balance += value
  end

  def touch_in(name)
    fail "Balance below #{MIN_BALANCE}" if self.check_balance < MIN_BALANCE
    puts "Penalty #{journey?}" if (journey?)
    @status = true
    @exit_station = nil
    @starting_station = name
    @station_zone = lookup_zone(name)
    @journey["Entry"] = @starting_station
    @journey_list.push @journey
  end

  def touch_out(name)
    pay(MIN_CHARGE)
    puts "Penalty" if(journey?)
    @status = false
    @starting_station = nil
    @exit_station = name
    @journey["Exit"] = @exit_station
    @journey_list.push @journey
  #  @journey = Hash.new
  end

  def journey?
    puts @starting_station
    #true unless(@starting_station ? nil : false)
    @starting_station == nil ? false : true
  end

  def check_balance
    @balance
  end

  def lookup_zone(station)
    @station.get_zone(station)
  end
  private

  def pay(fare)
    @balance -= fare
  end

end

class Station
 attr_reader :zone
  def initialize
    @zone = {"Bank" => "Zone 1", "Stratford" => "Zone 2"}
  end

  def get_zone(station)
    @zone[station] if @zone.include?(station)
  end

>>>>>>> e9b1badb8704adc338487b85b9921866490f6e14
end
