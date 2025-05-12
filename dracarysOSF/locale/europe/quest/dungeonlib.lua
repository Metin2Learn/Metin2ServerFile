--[[
 Dungeon Information System Library, Version 4.4
 Copyright 2019 Owsap Productions
]]

--[[ TODO:
 Change index with map_index for better organization and consultation
 Improve query updates
 Use client-side map names by map index
 Add SQL queries to questlua_dungeon
]]

dungeonLib = {}
dungeonInfo = {}
dungeonInfo.table = {
	--[[
	{ -- metin2_map_devilcatacomb
		["status"] = 0, -- Dungeon status [ 0 (Open), 1 (Running), 2 (Closed) ]
		["type"] = 1, -- Dungeon type [ 0 (Unknown), 1 (Private), 2 (Global) ]
		["organization"] = 1, -- Dungeon organization [ 0 (None), 1 (Party), 2 (Guild) ]
		["level_limit"] = {75, 0}, -- Dungeon level limit [ min_level, max_level ] ({0, 0} = {1, 120} : no limit)
		["party_member_limit"] = {1, 0}, -- Dungeon party members [ min_members, max_members ] ({0, 0} = {1, 8} : no limit)
		["map_index"] = 216, -- Dungeon map index * important
		["map_coords"] = {5917, 999}, -- Dungeon map coordinates [ x, y ]
		["cooldown"] = 60*30, -- [ 0 (None) ] | Ex: 60 * 60 * 3 = 3 hours
		["duration"] = 60*60*1, -- [ 0 (None) ] | Ex: 60 * 60 * 3 = 3 hours
		["entrance_map_index"] = 65, -- Entrance map index
		["strength_bonus"] = 63, -- Strength bonus id against dungeon monsters
		["resistance_bonus"] = 35, -- Resistance bonus id against dungeon monsters
		["required_item"] = {30319, 1}, -- Required dungeon item [ vnum, count]
	},
	]]
	{ -- metin2_map_deviltower1
		["status"] = 0,
		["type"] = 2,
		["organization"] = 0,
		["level_limit"] = { 45, 0 },
		["party_member_limit"] = { 0, 0 },
		["map_index"] = 66, -- metin2_map_deviltower1
		["map_coords"] = {5908, 1112},
		["cooldown"] = 0,
		["duration"] = 0,
		["entrance_map_index"] = 65, -- metin2_map_milgyo
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = {0, 0},
	},
	{ -- metin2_map_devilcatacomb
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 75, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 216, -- metin2_map_devilcatacomb
		["map_coords"] = { 5917, 999 },
		["cooldown"] = 60 * 30,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 65, -- metin2_map_milgyo
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 30319, 1 },
	},
	{ -- metin2_map_spiderdungeon_03
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 50, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 217, -- metin2_map_spiderdungeon_03
		["map_coords"] = { 691, 6108 },
		["cooldown"] = 60 * 60 * 1,
		["duration"] = 60 * 30,
		["entrance_map_index"] = 217, -- metin2_map_spiderdungeon_03
		["strength_bonus"] = 0,
		["resistance_bonus"] = 37,
		["required_item"] = { 30324, 1 },
	},
	{ -- metin2_map_skipia_dungeon_boss
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 104, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 208, -- metin2_map_skipia_dungeon_boss
		["map_coords"] = { 1812, 12208 },
		["cooldown"] = 60 * 30,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 73, -- metin2_map_skipia_dungeon_02
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 30179, 3 },
	},
	{ -- metin2_map_n_flame_dungeon_01
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 104, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 351, -- metin2_map_n_flame_dungeon_01
		["map_coords"] = { 6142, 7068 },
		["cooldown"] = 60 * 30,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 62, -- metin2_map_n_flame_01
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 71175, 1 },
	},
	{ -- metin2_map_n_snow_dungeon_01
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 104, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 352, -- metin2_map_n_snow_dungeon_01
		["map_coords"] = { 4324, 1650 },
		["cooldown"] = 60 * 30,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 61, -- map_n_snowm_01
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 0, 0 },
	},
	{ -- metin2_map_n_flame_dragon
		["status"] = 0,
		["type"] = 1,
		["organization"] = 2,
		["level_limit"] = { 75, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 356, -- metin2_map_n_flame_dragon
		["map_coords"] = { 5972, 7000 },
		["cooldown"] = 60 * 30,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 62, -- metin2_map_n_flame_01
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 0, 0 },
	},
	{ -- metin2_map_mt_th_dungeon_01
		["status"] = 0,
		["type"] = 2,
		["organization"] = 0,
		["level_limit"] = { 95, 0 },
		["party_member_limit"] = { 1, 0 },
		["map_index"] = 354, -- metin2_map_mt_th_dungeon_01
		["map_coords"] = { 12777, 17345 },
		["cooldown"] = 0,
		["duration"] = 0,
		["entrance_map_index"] = 302, -- metin2_map_dawnmistwood
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 0, 0 },
	},
	{ -- metin2_map_dawnmist_dungeon_01
		["status"] = 0,
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = { 95, 0 },
		["party_member_limit"] = { 2, 0 },
		["map_index"] = 353, -- metin2_map_dawnmist_dungeon_01
		["map_coords"] = { 8292, 14184 },
		["cooldown"] = 60 * 60 * 1,
		["duration"] = 60 * 60 * 1,
		["entrance_map_index"] = 353, -- metin2_map_dawnmist_dungeon_01
		["strength_bonus"] = 22,
		["resistance_bonus"] = 37,
		["required_item"] = { 30613, 1 },
	},
}

dungeonInfo.bonus_name = {
	[0] = "Nenhum",
	[19] = "Forte contra Orcs",
	[22] = "Forte contra Demónios",
	[63] = "Forte contra Monstros",
	[35] = "Resistência ao Fogo",
	[37] = "Resistência a Magias",
	[38] = "Resistência ao Vento",
}

function dungeonLib.update_ranking(dungeonID, rankingType)
	cmdchat(string.format("CleanDungeonRanking"))
	d.get_rank(dungeonID, rankingType)
	cmdchat(string.format("OpenDungeonRanking"))
end

function dungeonLib.get_wait_time(wait_time)
	if wait_time > 0 then
		return wait_time
	end

	return 0
end

function dungeonLib.update()
	local dungeonTable = dungeonInfo.table

	if table.getn(dungeonTable) == 0 then return end

	cmdchat(string.format("DungeonInfo %d", q.getcurrentquestindex()))
	cmdchat(string.format("CleanDungeonInfo"))

	for index in ipairs(dungeonTable) do
		-- Get indexed data from dungeon table
		dungeonStatus = dungeonTable[index]["status"] -- todo: (game.get_event_flag("dungeon") ~? 0:open | >0:closed/running )
		dungeonType = dungeonTable[index]["type"]
		dungeonOrganization = dungeonTable[index]["organization"]
		dungeonLevelMinLimit = dungeonTable[index]["level_limit"][1]
		dungeonLevelMaxLimit = dungeonTable[index]["level_limit"][2]
		dungeonPartyMemberMinLimit = dungeonTable[index]["party_member_limit"][1]
		dungeonPartyMemberMaxLimit = dungeonTable[index]["party_member_limit"][2]
		dungeonMapIndex = dungeonTable[index]["map_index"]
		dungeonMapCoordX = dungeonTable[index]["map_coords"][1]
		dungeonMapCoordY = dungeonTable[index]["map_coords"][2]
		dungeonCooldown = dungeonTable[index]["cooldown"]
		dungeonDuration = dungeonTable[index]["duration"]
		dungeonEntranceMapIndex = dungeonTable[index]["entrance_map_index"]
		dungeonStrengthBonus = dungeonTable[index]["strength_bonus"]
		dungeonResistanceBonus = dungeonTable[index]["resistance_bonus"]
		dungeonItemVnum = dungeonTable[index]["required_item"][1]
		dungeonItemCount = dungeonTable[index]["required_item"][2]

		-- Get dungeon rank from indexed dungeon
		if dungeonMapIndex > 0 then
			dungeonFinished = d.get_my_rank(dungeonMapIndex, 1) -- dungeonLib.get_rank(index, pc.get_name(), 1)
			dungeonFastestTime = d.get_my_rank(dungeonMapIndex, 2) -- dungeonLib.get_rank(index, pc.get_name(), 2)
			dungeonHighestDamage = d.get_my_rank(dungeonMapIndex, 3) -- dungeonLib.get_rank(index, pc.get_name(), 3)

			if dungeonMapIndex == 351 then
				dungeonWaitTime = dungeonLib.get_wait_time(pc.getf("flame_dungeon", "exit_time"))
			elseif dungeonMapIndex == 352 then
				dungeonWaitTime = dungeonLib.get_wait_time(pc.getf("snow_dungeon", "exit_time"))
			elseif dungeonMapIndex == 353 then
				dungeonWaitTime = dungeonLib.get_wait_time(pc.getf("erebus_dungeon", "exit_time"))
			elseif dungeonMapIndex == 208 then
				dungeonWaitTime = dungeonLib.get_wait_time(pc.getf("dragon_lair_access", "exit_time"))
			elseif dungeonMapIndex == 216 then
				dungeonWaitTime = dungeonLib.get_wait_time(pc.getf("devilcatacomb_zone", "last_exit_time"))
			else
				dungeonWaitTime = 0
			end
		else
			dungeonFinished = 0
			dungeonFastestTime = 0
			dungeonHighestDamage = 0
		end

		-- Converts data to string
		dungeonStrengthBonusName = dungeonInfo.bonus_name[dungeonStrengthBonus]
		dungeonResistanceBonusName = dungeonInfo.bonus_name[dungeonResistanceBonus]

		-- Replace converted strings for client communication
		dungeonStrengthBonusName = string.gsub(dungeonStrengthBonusName, " ", "_")
		dungeonResistanceBonusName = string.gsub(dungeonResistanceBonusName, " ", "_")

		if dungeonLevelMinLimit <= 0 then dungeonLevelMinLimit = 1 end
		if dungeonLevelMaxLimit <= 0 then dungeonLevelMaxLimit = 120 end
		if dungeonPartyMemberMinLimit <= 0 then dungeonPartyMemberMinLimit = 1 end
		if dungeonPartyMemberMaxLimit <= 0 then dungeonPartyMemberMaxLimit = 8 end

		cmdchat(string.format("UpdateDungeonInfo %d %u %d %d %d %d %d %d %d %d %d %d %d %d %s %s %d %d %d %d %d",
			dungeonStatus,
			dungeonWaitTime,
			dungeonType,
			dungeonOrganization,
			dungeonLevelMinLimit,
			dungeonLevelMaxLimit,
			dungeonPartyMemberMinLimit,
			dungeonPartyMemberMaxLimit,
			dungeonMapIndex,
			dungeonMapCoordX,
			dungeonMapCoordY,
			dungeonCooldown,
			dungeonDuration,
			dungeonEntranceMapIndex,
			dungeonStrengthBonusName,
			dungeonResistanceBonusName,
			dungeonItemVnum,
			dungeonItemCount,
			dungeonFinished,
			dungeonFastestTime,
			dungeonHighestDamage
		))
	end
end
