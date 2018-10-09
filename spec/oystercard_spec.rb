require './lib/oystercard.rb'
describe Oystercard do
  it 'Check balance' do
    expect(subject.balance).to eq 0
  end

  it 'Add balance of £10' do
    expect{ subject.top_up 10}.to change{subject.balance}.by 10
  end

  it 'I want a maximum limit (of £90) on my card' do
    topup_amt = 91
    max_bal = Oystercard::MAXIMUM_BALANCE
    expect{ subject.top_up(topup_amt)}.to raise_error("You have tried to add #{topup_amt} but the max you can add is
    #{max_bal-subject.balance}")
  end

  it 'Deducts daily fare from the Oyster' do
    max_bal = Oystercard::MAXIMUM_BALANCE
    subject.top_up(max_bal)
    expect{subject.deduct 10}.to change{subject.balance}.by -10
  end

  it "Throws error if the deduct is more than allowed balance" do
    ded_amt = 91
    max_bal = Oystercard::MAXIMUM_BALANCE
    subject.top_up(max_bal)
    expect{ subject.deduct(ded_amt)}.to raise_error("Cannot deduct #{ded_amt} from #{subject.balance} due to in-sufficient balance")
  end

  it "Throws an error if touch_in is performed without balance" do
    expect{subject.touch_in}.to raise_error("You have no balance: Top up before using") if(subject.balance == 0)
  end

  it "Throws an error if touch_out is performed without balance" do
    journey = 5
    expect{subject.touch_out(5)}.to raise_error("You have no balance: Top up before using") if(subject.balance == 0)
  end

  it "Balance must change after a trip" do
    journey = 5
    subject.top_up(10)
    expect{subject.touch_out(journey)}.to change{subject.balance}.by -(subject.balance-journey)
  end

  it "Cannot perfom a touch out without making a journey" do
    journey = 5
    s = Oystercard.new
    s.top_up(10)
    #subject.touch_in
    expect{s.touch_out(5)}.to raise_error "Journey not initiated" unless(!s.in_journey)
  end

  it "Cannot perfom a touch in twice" do
    journey = 5
    s = Oystercard.new
    s.top_up(10)
    s.touch_in
    expect{s.touch_in}.to raise_error "Journey already initiated" unless(s.in_journey)
  end
end
