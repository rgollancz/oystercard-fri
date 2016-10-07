# oystercard

Fixes needed:

- If you touch in twice, it doesn’t add a journey to the journey history (with a blank exit station)
- If you touch out twice, it can’t deduct the penalty fare

<!-- When you create JourneyLog, instantiate Journey with a blank hash for entry and exit station
In JourneyLog, have a @live_journey variable
Update past_journeys at normal touch in and out
Clear the @live_journey variable at touch_out (and create a new instance of Journey?)
	- If someone touches in and the current_journey variable is not nil, they must have not touched out, so push the existing hash, and reset current_journey using station they just touch in at
	- If someone touches out and the @live_journey’s entry station is nil, they must not have touched in, so update the @live_journey(create a Journey) variable and push the hash with the empty entry_station and charge them the penalty fare
		- Then reset the @live_journey and create and new instance of Journey -->
