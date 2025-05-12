-- #################################################################
-- ##                                                             ##
-- ##                      MULTI_LOCALE.LUA                       ##
-- ##                                                             ##
-- #################################################################

--[[
 This file replaces the old locale.lua since it's a static file with
 one big array we are not able to transalte most of them unless we
 make a function to get the player's locale.
 
 Below are some functions that do the job.
 will be stored into them and isn't possible to change then 
]]

fortune_words = function(index, line)
	local fortuneWords = {
		{
			locale_quest(2500),
			locale_quest(2499)
		},
		{
			locale_quest(2502),
			locale_quest(2501)
		},
		{
			locale_quest(2504),
			locale_quest(2503)
		},
		{
			locale_quest(2506),
			locale_quest(2505)
		},
		{
			locale_quest(2508),
			locale_quest(2507)
		},
		{
			locale_quest(2510),
			locale_quest(2509)
		},
		{
			locale_quest(2512),
			locale_quest(2511)
		},
	}
	index = index or math.random(1, table.getn(fortuneWords))
	line = line or 1
	return fortuneWords[index][line]
end

-- locale.map_name
map_name = function(map_index)
	local mapName = {
		[61] = locale_quest(2691),
		[62] = locale_quest(2692),
		[63] = locale_quest(2693),
		[64] = locale_quest(2694),
	}
	return mapName[map_index]
end

-- locale.empire_names
empire_names = function(empire)
	local empireName = {
		[0] = locale_quest(2477),
		[1] = locale_quest(2478),
		[2] = locale_quest(2479),
		[3] = locale_quest(2480),
	}
	return empireName[empire]
end

-- locale.GM_SKILL_NAME_DICT
get_skill_name_by_vnum = function(vnum)
	return skill_name(vnum)
end

-- BuildSkillList
function BuildLocaleSkillList(job, group)
	local skill_vnum_list = {}
	local skill_name_list = {}
	if pc.get_skill_group() != 0 then
		local skill_list = special.active_skill_list[job + 1][group]
		table.foreachi( skill_list,
			function(i, t)
				local lev = pc.get_skill_level(t)
				if lev > 0 then
					local name = skill_name(t)
					if name != nil then
						table.insert(skill_vnum_list, t)
						table.insert(skill_name_list, name)
					end
				end
			end
		)
	end
	table.insert(skill_vnum_list, 0)
	table.insert(skill_name_list, locale_quest(2426))
	return { skill_vnum_list, skill_name_list }
end
