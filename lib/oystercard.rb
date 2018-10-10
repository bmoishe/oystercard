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
    @status = true
    @starting_station = name
    @station_zone = lookup_zone(name)
    @journey = Hash.new
    @journey["Entry"] = name
    @exit_station = nil
  end

  def touch_out(name)
    pay(MIN_CHARGE)
    @status = false
    @starting_station = nil
    @exit_station = name
    @journey["Exit"] = name
    @journey_list.push @journey
  end

  def journey?
    true unless(@starting_station ? nil : false)
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

end
