class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
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

  def deduct(money)
    raise "Cannot deduct #{money} from #{@balance} due to in-sufficient balance" if(money > @balance)
    @balance -= money
    balance
  end

end
