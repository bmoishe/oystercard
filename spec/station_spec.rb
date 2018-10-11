require './lib/oystercard.rb'

describe Station do
  it "Should have an zone values defined" do
    z = Station.new
    expect(z.zone["Bank"]).to eq "Zone 1"
  end

  it "Returns a specific zone through get zone method" do
    expect(subject.get_zone("Stratford")).to eq "Zone 2"
  end
end
