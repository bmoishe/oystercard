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

  it 'Check balance' do
    expect(subject.balance).to eq 0
  end

  it 'Add balance of £10' do
    expect{ subject.top_up 10}.to change{subject.balance}.by 10
  end
end
