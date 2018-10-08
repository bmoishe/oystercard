class Oystercard
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "You have tried to add #{money} but the max you can add is
    #{90-@balance}" if (money > 90 - @balance)
    @balance += money
  end

  def balance
    @balance
  end
end
