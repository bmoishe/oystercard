class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(val)
    fail "Maximum balance of #{MAX_BALANCE} exceeded!" if balance + val > MAX_BALANCE
    @balance += val
  end

end
