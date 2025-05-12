quest pet_system begin
	state start begin

		function get_pet_info(itemVnum)
			if pet_system.pet_info_map==nil then
				pet_system.pet_info_map = {
				-- [ITEM VNUM] MOB_VNUM, DEFAULT NAME
					[53001] = {34001, " - Pet", 0},
					[53002] = {34002, " - Pet", 0},
					[53003] = {34003, " - Pet", 0},
					[53005] = {34004, " - Pet", 1},
					[53006] = {34009, " - Pet", 1},
					[53007] = {34010, " - Pet", 0},
					[53008] = {34011, " - Pet", 0},
					[53009] = {34012, " - Pet", 0},
					[53010] = {34008, " - Pet", 0},
					[53011] = {34007, " - Pet", 0},
					[53012] = {34005, " - Pet", 0},
					[53013] = {34006, " - Pet", 0},
					[53014] = {34013, " - Pet", 0},
					[53015] = {34014, " - Pet", 0},
					[53016] = {34015, " - Pet", 0},
					[53017] = {34016, " - Pet", 0},
					[53018] = {34020, " - Pet", 0},
					[53019] = {34019, " - Pet", 0},
					[53020] = {34017, " - Pet", 0},
					[53021] = {34018, " - Pet", 0},
					[53022] = {34021, " - Pet", 0},
					[53023] = {34022, " - Pet", 0},
					[53024] = {34023, " - Pet", 0},
					[53025] = {34024, " - Pet", 0},
					[53218] = {34023, " - Pet", 0},
					[53219] = {34023, " - Pet", 0},
					[53220] = {34024, " - Pet", 0},
					[53221] = {34024, " - Pet", 0},
					[53222] = {34026, " - Pet", 0},
					[53223] = {34027, " - Pet", 0},
					[53224] = {34028, " - Pet", 0},
					[53225] = {34029, " - Pet", 0},
					[53226] = {34030, " - Pet", 0},
					[53227] = {34031, " - Pet", 0},
					[53228] = {34032, " - Pet", 0},
					[53229] = {34033, " - Pet", 0},
					[53230] = {34034, " - Pet", 0},
					[53231] = {34035, " - Pet", 0},
					[53232] = {34039, " - Pet", 0},
					[53233] = {34055, " - Pet", 0},
					[53234] = {34056, " - Pet", 0},
					[53236] = {34057, " - Pet", 0},
					[53237] = {34058, " - Pet", 0},
					[53240] = {34059, " - Pet", 0},
					[53241] = {34060, " - Pet", 0},
					[53242] = {34063, " - Pet", 0},
					[53244] = {34064, " - Pet", 0},
					[53245] = {34065, " - Pet", 0},
					[53247] = {34066, " - Pet", 0},
					[53248] = {34067, " - Pet", 0},
					[53249] = {34068, " - Pet", 0},
					[53250] = {34069, " - Pet", 0},
					[53251] = {34070, " - Pet", 0},
					[53252] = {34071, " - Pet", 0},
					[53253] = {34076, " - Pet", 0},
					[53254] = {34077, " - Pet", 0},
					[53255] = {34078, " - Pet", 0},
					[53256] = {34079, " - Pet", 0},
					[53257] = {34080, " - Pet", 0},
					[53258] = {34081, " - Pet", 0},
					[53259] = {34082, " - Pet", 0},
					[53260] = {34083, " - Pet", 0},
					[53261] = {34084, " - Pet", 0},
					[53262] = {34085, " - Pet", 0},
					[53263] = {34086, " - Pet", 0},
					[53264] = {34087, " - Pet", 0},
					[53265] = {34088, " - Pet", 0},
					[53266] = {34089, " - Pet", 0},
					[53267] = {34090, " - Pet", 0},
					[53268] = {34091, " - Pet", 0},
					[53269] = {34092, " - Pet", 0},
					[53270] = {34093, " - Pet", 0},
					[53271] = {34094, " - Pet", 0},
					[53272] = {34095, " - Pet", 0},
					[53273] = {34096, " - Pet", 0},
					[53274] = {34097, " - Pet", 0},
					[53275] = {34098, " - Pet", 0},
					[53276] = {34099, " - Pet", 0},
					[53277] = {34100, " - Pet", 0},
					[53278] = {34101, " - Pet", 0},
					[53279] = {34102, " - Pet", 0},
					[53280] = {34103, " - Pet", 0},
					[53281] = {34104, " - Pet", 0},
					[53282] = {34105, " - Pet", 0},
					[53283] = {34106, " - Pet", 0},
					[53284] = {34107, " - Pet", 0},
					[53285] = {34108, " - Pet", 0},
					[53286] = {34109, " - Pet", 0},
					[53287] = {34110, " - Pet", 0},
					[53288] = {34111, " - Pet", 0},
					[53289] = {34112, " - Pet", 0},
				}
			end
			return pet_system.pet_info_map[itemVnum]
		end

		function get_spawn_effect_file(idx)
			if pet_system.effect_table==nil then
				pet_system.effect_table = {
					[0] = nil,
					[1] = "d:\\\\ymir work\\\\effect\\\\etc\\\\appear_die\\\\npc2_appear.mse",
				}
			end
			return pet_system.effect_table[idx]
		end

		when
			-- 53001~53026 (no 53003, 53026)
			53001.use or 53002.use or 53003.use or 53005.use or 53006.use or 53007.use or 53008.use or 53009.use or
			53010.use or 53011.use or 53012.use or 53013.use or 53014.use or 53015.use or 53016.use or 53017.use or 53018.use or 53019.use or
			53020.use or 53021.use or 53022.use or 53023.use or 53024.use or 53025.use or -- 53004.use or 53026.use or
			-- 53218~53251
			53218.use or 53219.use or
			53220.use or 53221.use or 53222.use or 53223.use or 53224.use or 53225.use or 53226.use or 53227.use or 53228.use or 53229.use or
			53230.use or 53231.use or 53232.use or 53233.use or 53234.use or 53236.use or 53237.use or 53240.use or 53241.use or
			53242.use or 53243.use or 53244.use or 53245.use or 53246.use or 53247.use or 53248.use or 53249.use or
			53250.use or 53251.use or 53252 use or
			-- new pets added by Tunga
			53253.use or 53254.use or 53255.use or 53256.use or 53257.use or 53258.use or 53259.use or
			53260.use or 53261.use or 53262.use or 53263.use or 53264.use or 53265.use or 53266.use or 53267.use or 53268.use or 53269.use or
			53270.use or 53271.use or 53272.use or 53273.use or 53274.use or 53275.use or 53276.use or 53277.use or 53278.use or 53279.use or
			53280.use or 53281.use or 53282.use or 53283.use or 53284.use or 53285.use or 53286.use or 53287.use or 53288.use or 53289 use
			--
		begin
			local pet_info = pet_system.get_pet_info(item.vnum)

			if null ~= pet_info then

				local mobVnum = pet_info[1]
				local petName = pet_info[2]
				local spawn_effect_file_name = pet_system.get_spawn_effect_file(pet_info[3])

				if true == pet.is_summon(mobVnum) then
					if spawn_effect_file_name ~= nil then
						pet.spawn_effect(mobVnum, spawn_effect_file_name)
					end
					pet.unsummon(mobVnum)
				else
					if pet.count_summoned() < 1 then
						pet.summon(mobVnum, petName, false)
					else
						syschat("Þu anda petini çaðýramazsýn. ")
					end
					if spawn_effect_file_name ~= nil then
						pet.spawn_effect(mobVnum, spawn_effect_file_name)
					end
				end -- if pet.is_summon
			end -- if null ~= pet_info

		end -- when
	end -- state
end -- quest
