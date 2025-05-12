quest guild_ranking begin
	state start begin
		when 11000.chat.locale_quest(4299) or
			11002.chat.locale_quest(4299) or
			11004.chat.locale_quest(4299) with pc.hasguild()
		begin
			say_title(locale_quest(1294))
			say(string.format(locale_quest(1749), guild.around_ranking_string()))
		end

		when 11000.chat.locale_quest(4300) or
			11002.chat.locale_quest(4300) or
			11004.chat.locale_quest(4300) with pc.hasguild()
		begin
			say_title(locale_quest(1294))
			say(string.format(locale_quest(1750), guild.high_ranking_string()))
		end

		when 11000.chat.locale_quest(4298) or
			11002.chat.locale_quest(4298) or
			11004.chat.locale_quest(4298) with pc.hasguild()
		begin
			say_title(locale_quest(1294))
			say(string.format(locale_quest(1751), guild.get_rank()))
			say(string.format(locale_quest(1752), guild.get_ladder_point()))
		end
	end
end
