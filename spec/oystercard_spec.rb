require "./lib/oystercard.rb"

describe Oystercard do
  it "should have a balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "can be topped up" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "increases the balance of a card" do
    card = Oystercard.new
    card.top_up(20)
    expect(card.balance).to eq 20
  end
end
