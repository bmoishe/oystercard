require './lib/oystercard.rb'
describe Oystercard do
  # let (:oyster) {double :Oystercard, :activate_card => true,
  #   :balance => 0 }
  # #it 'Activate card' do
  #   #allow(oyster).to receive(:activate_card) { 0 }
  #   #expect(oyster.activate_card).to eq 0
  # it 'Add money' do
  #   expect(oyster.balance).to eq :balance + add_money
  # end
  #before(:each) do

  #end

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

end
