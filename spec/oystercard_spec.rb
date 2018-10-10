require './lib/oystercard.rb'

describe Oystercard do

  it 'should have an initialisation balance of 0' do
    expect(subject.balance).to eq 0
  end
end


describe Oystercard do
  let(:station) { double :station }
  #before(:each) {skip("Awaiting code refactor.") }
  before(:each) { subject.top_up(10) }

  it 'should allow us to top_up the card balance' do
    expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
  end

  it 'should not allow us to have a balance of greater than 90' do
    maximum_balance = Oystercard::MAX_BALANCE
    expect{ subject.top_up(100) }.to raise_error "Max balance of #{ maximum_balance }."
  end

  it 'should change status when touched in at start of journey' do
    expect{ subject.touch_in(station) }.to change{ subject.status }.to eq true
  end

  it 'should change status when touched out at end of journey' do
    subject.touch_in(station)
    expect{ subject.touch_out }.to change{ subject.status }.to eq false
  end

  it 'should report being in a journey or not' do
  expect(subject.journey?).to eq(true).or eq(false)
  end

  it "should raise an error if touching in with balance less than the minimum amount " do
    allow(subject).to receive(:check_balance) { 0 }
    minimum_balance = Oystercard::MIN_BALANCE
    expect{subject.touch_in(station)}.to raise_error "Balance below #{minimum_balance}"
  end

  it "should deduct a fare at the end of a journey" do
    minimum_charge = Oystercard::MIN_CHARGE
    expect{ subject.touch_out }.to change{ subject.balance }.by(- minimum_charge)
  end

  it 'should report starting station after touch_in' do
    subject.touch_in(station)
    expect(subject.starting_station).to eq station
  end

  it 'should forget starting station on touch out, setting it to nil.' do
    subject.touch_in(station)
    subject.touch_out
    expect(subject.starting_station).to eq nil
  end

end
