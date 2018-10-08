require "./lib/oystercard.rb"

describe Oystercard do

  it "should have a balance of 0" do
    expect(subject.balance).to eq(0)
  end
  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    # it "increases the balance of a card" do
    #   subject.deduct(30)
    # expect{ subject.top_up 20 }.to change{ subject.balance }.by 20
    # end

    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }

    it "raises an error when maximum balance is exceeded" do
      maximum_balance = Oystercard::MAX_BALANCE
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded!"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts an amount from the balance" do
      expect{ subject.deduct 20 }.to change{ subject.balance }.by -20
    end
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end
end
