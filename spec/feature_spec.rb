require "./lib/oystercard.rb"

card = Oystercard.new
card.top_up 50
card.touch_in("Bank")
card.touch_out("Stratford")
card.exit_station
card.journey
card.touch_in("Stratford")
card.touch_out("Bank")
card.journey_list
  [{"Entry"=>"Bank", "Exit"=>"Stratford"},{"Entry"=>"Stratford", "Exit"=>"Bank"}]
