require './lib/oystercard'
oyster = Oystercard.new
oyster.top_up(10)
oyster.balance
oyster.touch_out(5)
oyster.balance


require './lib/oystercard'
oyster = Oystercard.new
oyster.top_up(10)
oyster.touch_in
oyster.entry_location
- provide entry location
oyster.touch_out(5)
oyster.balance
