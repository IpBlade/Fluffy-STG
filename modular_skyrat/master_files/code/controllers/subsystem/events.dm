/datum/controller/subsystem/events/reschedule()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	if(!SSticker.HasRoundStarted()) // Roundstart
		active_intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer initialising for roundstart at [active_intensity_multiplier]x")
		message_admins("ICES: Event timer initialising for roundstart at [active_intensity_multiplier]x")
		return
	else if(filter_threshold < intensity_low_players) // Lowpop gets events less often
		active_intensity_multiplier = intensity_low_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else if(filter_threshold < intensity_mid_players) // Midpop gets events less often
		active_intensity_multiplier = intensity_mid_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else
		active_intensity_multiplier = intensity_high_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (HIGHPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (HIGHPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")

	log_game("ICES: Reschedule proc calling for timed intensity credit")
	change_intensity_credits(2, 1, TRUE, TRUE, FALSE)
