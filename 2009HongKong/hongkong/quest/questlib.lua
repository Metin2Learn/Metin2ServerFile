CONFIRM_NO = 0
CONFIRM_YES = 1
CONFIRM_OK = 1
CONFIRM_TIMEOUT = 2

MALE = 0
FEMALE = 1

--quest.create = function(f) return coroutine.create(f) end
--quest.process = function(co,args) return coroutine.resume(co, args) end
setstate = q.setstate
newstate = q.setstate

q.set_clock = function(name, value) q.set_clock_name(name) q.set_clock_value(value) end
q.set_counter = function(name, value) q.set_counter_name(name) q.set_counter_value(value) end
c_item_name = function(vnum) return ("[ITEM value;"..vnum.."]") end
c_mob_name = function(vnum) return ("[MOB value;"..vnum.."]") end

-- d.set_folder = function (path) raw_script("[SET_PATH path;"..path.."]") end
-- d.set_folder = function (path) path.show_cinematic("[SET_PATH path;"..path.."]") end
-- party.run_cinematic = function (path) party.show_cinematic("[RUN_CINEMATIC value;"..path.."]") end

newline = "[ENTER]"
function color256(r, g, b) return "[COLOR r;"..(r/255.0).."|g;"..(g/255.0).."|b;"..(b/255.0).."]" end
function color(r,g,b) return "[COLOR r;"..r.."|g;"..g.."|b;"..b.."]" end
function delay(v) return "[DELAY value;"..v.."]" end
function setcolor(r,g,b) raw_script(color(r,g,b)) end
function setdelay(v) raw_script(delay(v)) end
function resetcolor(r,g,b) raw_script("[/COLOR]") end
function resetdelay(v) raw_script("[/DELAY]") end

-- minimap¿¡ µ¿±×¶ó¹Ì Ç¥½Ã
function addmapsignal(x,y) raw_script("[ADDMAPSIGNAL x;"..x.."|y;"..y.."]") end

-- minimap µ¿±×¶ó¹Ìµé ¸ðµÎ Å¬¸®¾î
function clearmapsignal() raw_script("[CLEARMAPSIGNAL]") end

-- Å¬¶óÀÌ¾ðÆ®¿¡¼­ º¸¿©ÁÙ ´ëÈ­Ã¢ ¹è°æ ±×¸²À» Á¤ÇÑ´Ù.
function setbgimage(src) raw_script("[BGIMAGE src;") raw_script(src) raw_script("]") end

-- ´ëÈ­Ã¢¿¡ ÀÌ¹ÌÁö¸¦ º¸¿©ÁØ´Ù.
function addimage(x,y,src) raw_script("[IMAGE x;"..x.."|y;"..y) raw_script("|src;") raw_script(src) raw_script("]") end

function makequestbutton(name)
	raw_script("[QUESTBUTTON idx;")
	raw_script(""..q.getcurrentquestindex()) 
	raw_script("|name;")
	raw_script(name) raw_script("]")
end

function make_quest_button_ex(name, icon_type, icon_name)
	test_chat(icon_type)
	test_chat(icon_name)
	raw_script("[QUESTBUTTON idx;")
	raw_script(""..q.getcurrentquestindex()) 
	raw_script("|name;")
	raw_script(name)
	raw_script("|icon_type;")
	raw_script(icon_type)
	raw_script("|icon_name;")
	raw_script(icon_name)
	raw_script("]")
end

function make_quest_button(name) makequestbutton(name) end

function send_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) set_skin(NOWINDOW) q.set_title(name) q.start() end

function send_letter(name) makequestbutton(name) set_skin(NOWINDOW) q.set_title(name) q.start() end
function clear_letter() q.done() end
function say_title(name) say(color256(255, 230, 186)..name..color256(196, 196, 196)) end
function say_reward(name) say(color256(255, 200, 200)..name..color256(196, 196, 196)) end
function say_pc_name() say(pc.get_name()..":") end
function say_size(width, height) say("[WINDOW_SIZE width;"..width.."|height;"..height.."]") end
function setmapcenterposition(x,y)
	raw_script("[SETCMAPPOS x;")
	raw_script(x.."|y;")
	raw_script(y.."]")
end
function say_item(name, vnum, desc)
	say("[INSERT_IMAGE image_type;item|idx;"..vnum.."|title;"..name.."|desc;"..desc.."]")
end
function say_item_vnum(vnum)
	say_item(item_name(vnum), vnum, "")
end

function pc_is_novice()
	if pc.get_skill_group()==0 then
		return true
	else
		return false
	end
end
function pc_get_exp_bonus(exp, text)
	say_reward(text)
	pc.give_exp2(exp)
	set_quest_state("levelup", "run")
end
function pc_get_village_map_index(index)
	return village_map[pc.get_empire()][index]
end

village_map = {
	{1, 3},
	{21, 23},
	{41, 43},
}

function npc_is_same_empire()
	if pc.get_empire()==npc.empire then
		return true
	else
		return false
	end
end

function npc_get_skill_teacher_race(pc_empire, pc_job, sub_job)
	if 1==sub_job then
		if 0==pc_job then
			return WARRIOR1_NPC_LIST[pc_empire]
		elseif 1==pc_job then
			return ASSASSIN1_NPC_LIST[pc_empire]
		elseif 2==pc_job then
			return SURA1_NPC_LIST[pc_empire]
		elseif 3==pc_job then
			return SHAMAN1_NPC_LIST[pc_empire]
		end	
	elseif 2==sub_job then
		if 0==pc_job then
			return WARRIOR2_NPC_LIST[pc_empire]
		elseif 1==pc_job then
			return ASSASSIN2_NPC_LIST[pc_empire]
		elseif 2==pc_job then
			return SURA2_NPC_LIST[pc_empire]
		elseif 3==pc_job then
			return SHAMAN2_NPC_LIST[pc_empire]
		end	
	end

	return 0
end 


function pc_find_square_guard_vid()
	if pc.get_empire()==1 then 
		return find_npc_by_vnum(11000) 
	elseif pc.get_empire()==2 then
		return find_npc_by_vnum(11002)
	elseif pc.get_empire()==3 then
		return find_npc_by_vnum(11004)
	end
	return 0
end

function pc_find_skill_teacher_vid(sub_job)
	local vnum=npc_get_skill_teacher_race(pc.get_empire(), pc.get_job(), sub_job)
	return find_npc_by_vnum(vnum)
end

function pc_find_square_guard_vid()
	local pc_empire=pc.get_empire()
	if pc_empire==1 then
		return find_npc_by_vnum(11000)
	elseif pc_empire==2 then
		return find_npc_by_vnum(11002)
	elseif pc_empire==3 then
		return find_npc_by_vnum(11004)
	end
end

function npc_is_same_job()
	local pc_job=pc.get_job()
	local npc_vnum=npc.get_race()

	-- test_chat("pc.job:"..pc.get_job())
	-- test_chat("npc_race:"..npc.get_race())
	-- test_chat("pc.skill_group:"..pc.get_skill_group())
	if pc_job==0 then
		if table_is_in(WARRIOR1_NPC_LIST, npc_vnum) then return true end
		if table_is_in(WARRIOR2_NPC_LIST, npc_vnum) then return true end
	elseif pc_job==1 then
		if table_is_in(ASSASSIN1_NPC_LIST, npc_vnum) then return true end
		if table_is_in(ASSASSIN2_NPC_LIST, npc_vnum) then return true end
	elseif pc_job==2 then
		if table_is_in(SURA1_NPC_LIST, npc_vnum) then return true end
		if table_is_in(SURA2_NPC_LIST, npc_vnum) then return true end
	elseif pc_job==3 then
		if table_is_in(SHAMAN1_NPC_LIST, npc_vnum) then return true end
		if table_is_in(SHAMAN2_NPC_LIST, npc_vnum) then return true end
	end

	return false
end

function npc_get_job()
	local npc_vnum=npc.get_race()

	if table_is_in(WARRIOR1_NPC_LIST, npc_vnum) then return COND_WARRIOR_1 end
	if table_is_in(WARRIOR2_NPC_LIST, npc_vnum) then return COND_WARRIOR_2 end
	if table_is_in(ASSASSIN1_NPC_LIST, npc_vnum) then return COND_ASSASSIN_1 end
	if table_is_in(ASSASSIN2_NPC_LIST, npc_vnum) then return COND_ASSASSIN_2 end
	if table_is_in(SURA1_NPC_LIST, npc_vnum) then return COND_SURA_1 end
	if table_is_in(SURA2_NPC_LIST, npc_vnum) then return COND_SURA_2 end
	if table_is_in(SHAMAN1_NPC_LIST, npc_vnum) then return COND_SHAMAN_1 end
	if table_is_in(SHAMAN2_NPC_LIST, npc_vnum) then return COND_SHAMAN_2 end
	return 0

end

function time_min_to_sec(value)
	return 60*value
end

function time_hour_to_sec(value)
	return 3600*value
end

function next_time_set(value, test_value)
	local nextTime=get_time()+value
	if is_test_server() then
		nextTime=get_time()+test_value
	end
	pc.setqf("__NEXT_TIME__", nextTime)
end

function next_time_is_now(value)
	if get_time()>=pc.getqf("__NEXT_TIME__") then
		return true
	else
		return false
	end
end

function table_get_random_item(self)
	return self[number(1, table.getn(self))]
end

function table_is_in(self, test)
	for i = 1, table.getn(self) do
		if self[i]==test then
			return true
		end
	end
	return false
end


function giveup_quest_menu(title)
    local s=select("ÁøÇàÇÑ´Ù", "Æ÷±âÇÑ´Ù")
    if 2==s then 
	say(title.." Äù½ºÆ®¸¦ Á¤¸»·Î")
	say("Æ÷±âÇÏ½Ã°Ú½À´Ï±î?")
	local s=select("³×, ±×·¸½À´Ï´Ù", "¾Æ´Õ´Ï´Ù")
	if 1==s then
	    say(title.."Äù½ºÆ®¸¦ Æ÷±âÇß½À´Ï´Ù")
	    restart_quest()
	end
    end
end

function restart_quest()
	set_state("start")
	q.done()
end

function complete_quest()
	set_state("__COMPLETE__")
	q.done()
end

function giveup_quest()
	set_state("__GIVEUP__")
	q.done()
end

function complete_quest_state(state_name)
	set_state(state_name)
	q.done()
end

function test_chat(log)
	if is_test_server() then
		chat(log)
	end
end

function bool_to_str(is)
	if is then
		return "true"
	else
		return "false"
	end
end

WARRIOR1_NPC_LIST 	= {20300, 20320, 20340, }
WARRIOR2_NPC_LIST 	= {20301, 20321, 20341, }
ASSASSIN1_NPC_LIST 	= {20302, 20322, 20342, }
ASSASSIN2_NPC_LIST 	= {20303, 20323, 20343, }
SURA1_NPC_LIST 		= {20304, 20324, 20344, }
SURA2_NPC_LIST 		= {20305, 20325, 20345, }
SHAMAN1_NPC_LIST 	= {20306, 20326, 20346, }
SHAMAN2_NPC_LIST 	= {20307, 20327, 20347, }

function skill_group_dialog(e, j, g) -- e = Á¦±¹, j = Á÷¾÷, g = ±×·ì
	e = 1 -- XXX ¸Þ½ÃÁö°¡ ³ª¶óº°·Î ÀÖ´Ù°¡ ÇÏ³ª·Î ÅëÇÕµÇ¾úÀ½
	

	-- ´Ù¸¥ Á÷¾÷ÀÌ°Å³ª ´Ù¸¥ Á¦±¹ÀÏ °æ¿ì
	if pc.job != j then
		say(locale.skill_group.dialog[e][pc.job][3])
	elseif pc.get_skill_group() == 0 then
	    if pc.level < 5 then
		    say(locale.skill_group.dialog[e][j][g][1])
		    return
	    end
		say(locale.skill_group.dialog[e][j][g][2])
		local answer = select(locale.yes, locale.no)

		if answer == 1 then
			--say(locale.skill_group.dialog[e][j][g][2])
			pc.set_skill_group(g)
		else
			--say(locale.skill_group.dialog[e][j][g][3])
		end
	--elseif pc.get_skill_group() == g then
		--say(locale.skill_group.dialog[e][j][g][4])
	--else
		--say(locale.skill_group.dialog[e][j][g][5])
	end
end

function show_horse_menu()
	if horse.is_mine() then			
		say(locale.horse_menu.menu)

		local s = 0
		if horse.is_dead() then
			s = select(locale.horse_menu.revive, locale.horse_menu.ride, locale.horse_menu.unsummon, locale.horse_menu.show_state ,locale.horse_menu.close)
		else
			s = select(locale.horse_menu.feed, locale.horse_menu.ride, locale.horse_menu.unsummon,  locale.horse_menu.show_state ,locale.horse_menu.close)
		end

		if s==1 then
			if horse.is_dead() then
				horse.revive()
			else
			    local food = horse.get_grade() + 50054 - 1
			    if pc.countitem(food) > 0 then
				pc.removeitem(food, 1)
				horse.feed()
			    else
				say(locale.need_item_prefix..item_name(food)..locale.need_item_postfix);
			    end
			end
		elseif s==2 then
		    horse.ride()
		elseif s==3 then
		    horse.unsummon()
		elseif s==4 then
			say("²{®É°¨ªºÅé¤O: "..horse.get_health_pct().."%")
		    say("²{®É°¨ªº­@¤O: "..horse.get_stamina_pct().."%")
			say("")
		elseif s==5 then													  
			-- do nothing
		end
	end
end

npc_index_table = {
    ['race'] = npc.getrace,
    ['empire'] = npc.get_empire,
}

pc_index_table = {
    ['weapon']		= pc.getweapon,
    ['level']		= pc.get_level,
    ['hp']		= pc.gethp,
    ['maxhp']		= pc.getmaxhp,
    ['sp']		= pc.getsp,
    ['maxsp']		= pc.getmaxsp,
    ['exp']		= pc.get_exp,
    ['nextexp']		= pc.get_next_exp,
    ['job']		= pc.get_job,
    ['money']		= pc.getmoney,
    ['gold'] 		= pc.getmoney,
    ['name'] 		= pc.getname,
    ['playtime'] 	= pc.getplaytime,
    ['leadership'] 	= pc.getleadership,
    ['empire'] 		= pc.getempire,
    ['skillgroup'] 	= pc.get_skill_group,
    ['x'] 		= pc.getx,
    ['y'] 		= pc.gety,
    ['local_x'] 	= pc.get_local_x,
    ['local_y'] 	= pc.get_local_y,
}

item_index_table = {
    ['vnum']		= item.get_vnum,
    ['name']		= item.get_name,
    ['size']		= item.get_size,
    ['count']		= item.get_count,
    ['type']		= item.get_type,
    ['sub_type']	= item.get_sub_type,
    ['refine_vnum']	= item.get_refine_vnum,
    ['level']		= item.get_level,
}

guild_war_bet_price_table = 
{
	10000,
	30000,
	50000,
	100000
}

function npc_index(t,i) 
    local npit = npc_index_table
    if npit[i] then
	return npit[i]()
    else
	return rawget(t,i)
    end
end

function pc_index(t,i) 
    local pit = pc_index_table
    if pit[i] then
	return pit[i]()
    else
	return rawget(t,i)
    end
end

function item_index(t, i)
    local iit = item_index_table
    if iit[i] then
	return iit[i]()
    else
	return rawget(t, i)
    end
end

setmetatable(pc,{__index=pc_index})
setmetatable(npc,{__index=npc_index})
setmetatable(item,{__index=item_index})

--coroutineÀ» ÀÌ¿ëÇÑ ¼±ÅÃÇ× Ã³¸®
function select(...)
	return q.yield('select', arg)
end

function select_table(table)
	return q.yield('select', table)
end

-- coroutineÀ» ÀÌ¿ëÇÑ ´ÙÀ½ ¿£ÅÍ ±â´Ù¸®±â
function wait()
	q.yield('wait')
end

function input()
	return q.yield('input')
end

function confirm(vid, msg, timeout)
	return q.yield('confirm', vid, msg, timeout)
end

function select_item()
    setskin(NOWINDOW)
    return q.yield('select_item')
end

--Àü¿ª º¯¼ö Á¢±Ù°ú °ü·ÃµÈ °è¿­
NOWINDOW = 0
NORMAL = 1
CINEMATIC = 2
SCROLL = 3

WARRIOR = 0
ASSASSIN = 1
SURA = 2
SHAMAN = 3

COND_WARRIOR_0 = 8
COND_WARRIOR_1 = 16
COND_WARRIOR_2 = 32
COND_WARRIOR = 56

COND_ASSASSIN_0 = 64
COND_ASSASSIN_1 = 128
COND_ASSASSIN_2 = 256
COND_ASSASSIN = 448

COND_SURA_0 = 512
COND_SURA_1 = 1024
COND_SURA_2 = 2048
COND_SURA = 3584

COND_SHAMAN_0 = 4096
COND_SHAMAN_1 = 8192
COND_SHAMAN_2 = 16384
COND_SHAMAN = 28672

PART_MAIN = 0
PART_HAIR = 3

GUILD_CREATE_ITEM_VNUM = 70101

QUEST_SCROLL_TYPE_KILL_MOB = 1
QUEST_SCROLL_TYPE_KILL_ANOTHER_EMPIRE = 2

apply = {
	["MAX_HP"]		= 1,
	["MAX_SP"]		= 2,
	["CON"]			= 3,
	["INT"]			= 4,
	["STR"]			= 5,
	["DEX"]			= 6,
	["ATT_SPEED"]		= 7,
	["MOV_SPEED"]		= 8,
	["CAST_SPEED"]		= 9,
	["HP_REGEN"]		= 10,
	["SP_REGEN"]		= 11,
	["POISON_PCT"]		= 12,
	["STUN_PCT"]		= 13,
	["SLOW_PCT"]		= 14,
	["CRITICAL_PCT"]	= 15,
	["PENETRATE_PCT"]	= 16,
	["ATTBONUS_HUMAN"]	= 17,
	["ATTBONUS_ANIMAL"]	= 18,
	["ATTBONUS_ORC"]	= 19,
	["ATTBONUS_MILGYO"]	= 20,
	["ATTBONUS_UNDEAD"]	= 21,
	["ATTBONUS_DEVIL"]	= 22,
	["STEAL_HP"]		= 23,
	["STEAL_SP"]		= 24,
	["MANA_BURN_PCT"]	= 25,
	["DAMAGE_SP_RECOVER"]	= 26,
	["BLOCK"]		= 27,
	["DODGE"]		= 28,
	["RESIST_SWORD"]	= 29,
	["RESIST_TWOHAND"]	= 30,
	["RESIST_DAGGER"]	= 31,
	["RESIST_BELL"]		= 32,
	["RESIST_FAN"]		= 33,
	["RESIST_BOW"]		= 34,
	["RESIST_FIRE"]		= 35,
	["RESIST_ELEC"]		= 36,
	["RESIST_MAGIC"]	= 37,
	["RESIST_WIND"]		= 38,
	["REFLECT_MELEE"]	= 39,
	["REFLECT_CURSE"]	= 40,
	["POISON_REDUCE"]	= 41,
	["KILL_SP_RECOVER"]	= 42,
	["EXP_DOUBLE_BONUS"]	= 43,
	["GOLD_DOUBLE_BONUS"]	= 44,
	["ITEM_DROP_BONUS"]	= 45,
	["POTION_BONUS"]	= 46,
	["KILL_HP_RECOVER"]	= 47,
	["IMMUNE_STUN"]		= 48,
	["IMMUNE_SLOW"]		= 49,
	["IMMUNE_FALL"]		= 50,
	["SKILL"]		= 51,
	["BOW_DISTANCE"]	= 52,
	["ATT_GRADE_BONUS"]	= 53,
	["DEF_GRADE_BONUS"]	= 54,
	["MAGIC_ATT_GRADE"]	= 55,
	["MAGIC_DEF_GRADE"]	= 56,
	["CURSE_PCT"]		= 57,
	["MAX_STAMINA"]		= 58,
	["ATTBONUS_WARRIOR"]	= 59,
	["ATTBONUS_ASSASSIN"]	= 60,
	["ATTBONUS_SURA"]	= 61,
	["ATTBONUS_SHAMAN"]	= 62,
	["ATTBONUS_MONSTER"]	= 63,
}

-- ·¹º§¾÷ Äù½ºÆ® -_-
special = {}

special.fortune_telling = 
{
--  { prob	Å©¸®	item	money	remove money
    { 1,	0,	20,	20,	0	}, -- 10
    { 499,	0,	10,	10,	0	}, -- 5
    { 2500,	0,	5,	5,	0	}, -- 1
    { 5000,	0,	0,	0,	0	},
    { 1500,	0,	-5,	-5,	20000	},
    { 499,	0,	-10,	-10,	20000	},
    { 1,	0,	-20,	-20,	20000	},
}

special.questscroll_reward =
{
	{1,	1500,	3000,	30027,	0,	0    },
	{2,	1500,	3000,	30028,	0,	0    },
	{3,	1000,	2000,	30034,	30018,	0    },
	{4,	1000,	2000,	30034,	30011,	0    },
	{5,	1000,	2000,	30011,	30034,	0    },
	{6,	1000,	2000,	27400,	0,	0    },
	{7,	2000,	4000,	30023,	30003,	0    },
	{8,	2000,	4000,	30005,	30033,	0    },
	{9,	2000,	8000,	30033,	30005,	0    },
	{10,	4000,	8000,	30021,	30033,	30045},
	{11,	4000,	8000,	30045,	30022,	30046},
	{12,	5000,	12000,	30047,	30045,	30055},
	{13,	5000,	12000,	30051,	30017,	30058},
	{14,	5000,	12000,	30051,	30007,	30041},
	{15,	5000,	15000,	30091,	30017,	30018},
	{16,	3500,	6500,	30021,	30033,	0    },
	{17,	4000,	9000,	30051,	30033,	0    },
	{18,	4500,	10000,	30056,	30057,	30058},
	{19,	4500,	10000,	30059,	30058,	30041},
	{20,	5000,	15000,	0,	0,	0    },
}

special.active_skill_list = {
	{
		{ 1, 2, 3, 4, 5},
		{ 16, 17, 18, 19, 20},
	},
	{
		{31, 32, 33, 34, 35},
		{46, 47, 48, 49, 50},
	},
	{
		{61, 62, 63, 64, 65, 66},
		{76, 77, 78, 79, 80, 81},
	},
	{
		{91, 92, 93, 94, 95, 96},
		{106, 107, 108, 109, 110, 111},
	},
}

special.skill_reset_cost = {
	2000,
	2000,
	2000,
	2000,
	2000,
	2000,
	4000,
	6000,
	8000,
	10000,
	14000,
	18000,
	22000,
	28000,
	34000,
	41000,
	50000,
	59000,
	70000,
	90000,
	101000,
	109000,
	114000,
	120000,
	131000,
	141000,
	157000,
	176000,
	188000,
	200000,
	225000,
	270000,
	314000,
	348000,
	393000,
	427000,
	470000,
	504000,
	554000,
	600000,
	758000,
	936000,
	1103000,
	1276000,
	1407000,
	1568000,
	1704000,
	1860000,
	2080000,
	2300000,
	2700000,
	3100000,
	3500000,
	3900000,
	4300000,
	4800000,
	5300000,
	5800000,
	6400000,
	7000000,
	8000000,
	9000000,
	10000000,
	11000000,
	12000000,
	13000000,
	14000000,
	15000000,
	16000000,
	17000000,
}

special.levelup_img = 
{
    [101] = "dog.tga",
    [102] = "wolf.tga",
    [103] = "wolf.tga",
    [104] = "wolf.tga",
    [105] = "wolf.tga",
    [105] = "wolf.tga",
    [106] = "wolf.tga",
    [107] = "wolf.tga",
    [108] = "wild_boar.tga",
    [109] = "wild_boar.tga",
    [110] = "bear.tga",
    [111] = "bear.tga",
    [112] = "bear.tga",
    [113] = "bear.tga",
    [114] = "tiger.tga",
    [115] = "tiger.tga",

    [301] = "bak_inf.tga",
    [302] = "bak_gung.tga",
    [303] = "bak_gen1.tga",
    [304] = "bak_gen2.tga",

    [401] = "huk_inf.tga",
    [402] = "huk_dol.tga",
    [403] = "huk_gen1.tga",
    [404] = "huk_gen2.tga",

    [501] = "o_inf.tga",
    [502] = "o_jol.tga",
    [503] = "o_gung.tga",
    [504] = "o_jang.tga",

    [601] = "ung_inf.tga",
    [602] = "ung_chuk.tga",
    [603] = "ung_tu.tga",
}

special.levelup_quest = {
    -- monster kill  monster   kill
    --    vnum		qty.		 vnum		qty.	 exp percent
{	0	,	0	,	0	,	0	,	0	}	,	--	lev	1
{	101	,	10	,	102	,	5	,	10	}	,	--	lev	2
{	101	,	20	,	102	,	10	,	10	}	,	--	lev	3
{	102	,	15	,	103	,	5	,	10	}	,	--	lev	4
{	103	,	10	,	104	,	10	,	10	}	,	--	lev	5
{	104	,	20	,	108	,	10	,	10	}	,	--	lev	6
{	108	,	10	,	105	,	5	,	10	}	,	--	lev	7
{	108	,	20	,	105	,	10	,	10	}	,	--	lev	8
{	105	,	15	,	109	,	5	,	10	}	,	--	lev	9
{	105	,	20	,	109	,	10	,	10	}	,	--	lev	10
{	109	,	10	,	110	,	5	,	10	}	,	--	lev	11
{	110	,	15	,	106	,	10	,	10	}	,	--	lev	12
{	106	,	20	,	111	,	5	,	10	}	,	--	lev	13
{	111	,	15	,	107	,	5	,	10	}	,	--	lev	14
{	111	,	20	,	107	,	10	,	10	}	,	--	lev	15
{	107	,	15	,	114	,	5	,	10	}	,	--	lev	16
{	107	,	20	,	114	,	10	,	10	}	,	--	lev	17
{	114	,	10	,	112	,	10	,	10	}	,	--	lev	18
{	112	,	20	,	113	,	10	,	10	}	,	--	lev	19
{	113	,	20	,	302	,	15	,	10	}	,	--	lev	20
{	302	,	20	,	115	,	10	,	"2-10"	}	,	--	lev	21
{	115	,	25	,	304	,	10	,	"2-10"	}	,	--	lev	22
{	304	,	20	,	401	,	40	,	"2-10"	}	,	--	lev	23
{	401	,	60	,	402	,	80	,	"2-10"	}	,	--	lev	24
{	501	,	80	,	404	,	20	,	"2-10"	}	,	--	lev	25
{	502	,	80	,	406	,	20	,	"2-10"	}	,	--	lev	26
{	406	,	30	,	504	,	20	,	"2-10"	}	,	--	lev	27
{	631	,	35	,	504	,	30	,	"2-10"	}	,	--	lev	28
{	631	,	40	,	632	,	30	,	"2-10"	}	,	--	lev	29
{	632	,	40	,	2102	,	30	,	"2-10"	}	,	--	lev	30
{	632	,	50	,	2102	,	45	,	"2-5"	}	,	--	lev	31
{	633	,	45	,	2001	,	40	,	"2-5"	}	,	--	lev	32
{	701	,	35	,	2103	,	30	,	"2-5"	}	,	--	lev	33
{	701	,	40	,	2103	,	40	,	"2-5"	}	,	--	lev	34
{	702	,	40	,	2002	,	30	,	"2-5"	}	,	--	lev	35
{	704	,	20	,	2106	,	20	,	"2-5"	}	,	--	lev	36
{	733	,	30	,	2003	,	20	,	"2-5"	}	,	--	lev	37
{	734	,	40	,	2004	,	20	,	"2-5"	}	,	--	lev	38
{	706	,	40	,	2005	,	30	,	"2-5"	}	,	--	lev	39
{	707	,	40	,	2108	,	20	,	"2-5"	}	,	--	lev	40
{	901	,	40	,	5123	,	25	,	"2-5"	}	,	--	lev	41
{	902	,	30	,	5123	,	30	,	"2-5"	}	,	--	lev	42
{	902	,	40	,	2031	,	35	,	"2-5"	}	,	--	lev	43
{	903	,	40	,	2031	,	40	,	"2-5"	}	,	--	lev	44
{	731	,	50	,	2032	,	45	,	"2-5"	}	,	--	lev	45
{	732	,	30	,	5124	,	30	,	"2-5"	}	,	--	lev	46
{	903	,	35	,	5125	,	30	,	"2-5"	}	,	--	lev	47
{	904	,	40	,	5125	,	35	,	"2-5"	}	,	--	lev	48
{	733	,	40	,	2033	,	45	,	"2-5"	}	,	--	lev	49
{	734	,	40	,	5126	,	20	,	"2-5"	}	,	--	lev	50
{	735	,	50	,	5126	,	30	,	"1-4"	}	,	--	lev	51
{	904	,	45	,	2034	,	45	,	"1-4"	}	,	--	lev	52
{	904	,	50	,	2034	,	50	,	"1-4"	}	,	--	lev	53
{	736	,	40	,	1001	,	30	,	"1-4"	}	,	--	lev	54
{	737	,	40	,	1301	,	35	,	"1-4"	}	,	--	lev	55
{	905	,	50	,	1002	,	30	,	"1-4"	}	,	--	lev	56
{	905	,	60	,	1002	,	40	,	"1-4"	}	,	--	lev	57
{	906	,	45	,	1303	,	40	,	"1-4"	}	,	--	lev	58
{	906	,	50	,	1303	,	45	,	"1-4"	}	,	--	lev	59
{	907	,	45	,	1003	,	40	,	"1-4"	}	,	--	lev	60

}

special.levelup_reward1 = 
{
	-- warrior assassin  sura  shaman
	{     0,        0,      0,      0 },
	{ 11200,    11400,  11600,  11800 }, -- °©¿Ê
	{ 12200,    12340,  12480,  12620 }, -- Åõ±¸
	{ 13000,    13000,  13000,  13000 }  -- ¹æÆÐ
}

-- levelup_reward1 Å×ÀÌºí Å©±âº¸´Ù ·¹º§ÀÌ ³ô¾ÆÁö¸é ¾Æ·¡
-- Å×ÀÌºíÀ» ÀÌ¿ëÇÏ¿© ¾ÆÀÌÅÛÀ» ÁØ´Ù.
special.levelup_reward3 = {
    -- pct   item #  item count
    {   33,  27002,  10 }, -- 25%
    {   67,  27005,  10 }, -- 25%
  --{   75,  27101,   5 }, -- 25%
    {  100,  27114,   5 }, -- 25%
}

special.levelup_reward_gold21 = 
{
    { 10000,	20 },
    { 20000,	50 },
    { 40000,	25 },
    { 80000,	3 },
    { 100000,	2 },
}
special.levelup_reward_gold31 =
{
    { 20000,	20 },
    { 40000,	40 },
    { 60000,	25 },
    { 80000,	10 },
    { 100000,	5 },
}
special.levelup_reward_gold41 =
{
    { 40000,	20 },
    { 60000,	40 },
    { 80000,	25 },
    { 100000,	10 },
    { 150000,	5 },
}
special.levelup_reward_gold51 =
{
    { 60000,	20 },
    { 80000,	40 },
    { 100000,	25 },
    { 150000,	10 },
    { 200000,	5 },
}

special.levelup_reward_exp21 =
{
    { 2,	9 },
    { 3,	14 },
    { 4,	39 },
    { 6,	24 },
    { 8,	9 },
    { 10,	4 },
}

special.levelup_reward_exp31 = 
{
    { 2,	10 },
    { 2.5,	15 },
    { 3,	40 },
    { 3.5,	25 },
    { 4,	8 },
    { 4.5,	5 },
    { 5,	2 },
}
special.levelup_reward_exp41 = 
{
    { 2,	10 },
    { 2.5,	15 },
    { 3,	40 },
    { 3.5,	25 },
    { 4,	8 },
    { 4.5,	5 },
    { 5,	2 },
}
special.levelup_reward_exp51 = 
{
    { 1,	10 },
    { 1.5,	15 },
    { 2,	40 },
    { 2.5,	25 },
    { 3,	8 },
    { 3.5,	5 },
    { 4,	2 },
}

special.levelup_reward_item_21 =
{
    -- no couple ring
    { { 27002, 10 }, { 27005, 10 }, { 27114, 10 } }, -- lev 21
    { 15080, 15100, 15120, 15140 }, -- lev 22
    { 16080, 16100, 16120, 16140 }, -- lev 23
    { 17080, 17100, 17120, 17140 }, -- lev 24
    { { 27002, 10 }, { 27005, 10 }, { 27114, 10 } }, -- lev 25
    { { 27003, 20 }, { 27006, 20 }, { 27114, 10 } }, -- over lev 25

    -- with couple ring
    -- { { 27002, 10 }, { 27005, 10 }, { 27114, 10 }, { 70301, 1 } }, -- lev 21
    -- { 15080, 15100, 15120, 15140, 70301 }, -- lev 22
    -- { 16080, 16100, 16120, 16140, 70301 }, -- lev 23
    -- { 17080, 17100, 17120, 17140, 70301 }, -- lev 24
    -- { { 27002, 10 }, { 27005, 10 }, { 27114, 10 }, { 70301, 1 } }, -- lev 25
    -- { { 27003, 20 }, { 27006, 20 }, { 27114, 10 } }, -- over lev 25
}

special.warp_to_pos = {
-- ½Â·æ°î
    {
	{ 402100, 673900 }, 
	{ 270400, 739900 },
	{ 321300, 808000 },
    },
--µµ¿°È­Áö
    {
--A 5994 7563 
--B 5978 6222
--C 7307 6898
	{ 599400, 756300 },
	{ 597800, 622200 },
	{ 730700, 689800 },
    },
--¿µºñ»ç¸·
    {
--A 2178 6272
	{ 217800, 627200 },
--B 2219 5027
	{ 221900, 502700 },
--C 3440 5025
	{ 344000, 502500 },
    },
--¼­ÇÑ»ê
    {
--A 4342 2906
	{ 434200, 290600 },
--B 3752 1749
	{ 375200, 174900 },
--C 4918 1736
	{ 491800, 173600 },
    },
}

special.devil_tower = 
{
    --{ 123, 608 },
    { 2048+126, 6656+384 },
    { 2048+134, 6656+147 },
    { 2048+369, 6656+629 },
    { 2048+369, 6656+401 },
    { 2048+374, 6656+167 },
    { 2048+579, 6656+616 },
    { 2048+578, 6656+392 },
    { 2048+575, 6656+148 },
}

special.lvq_map = {
	{ -- "A1" 1
		{},
	
		{ { 440, 565 }, { 460, 771 }, { 668, 800 },},
		{ { 440, 565 }, { 460, 771 }, { 668, 800 },},
		{ { 440, 565 }, { 460, 771 }, { 668, 800 },},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		
		{{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
		{{853,557}, {845,780}, {910,956},},
		{{853,557}, {845,780}, {910,956},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		{{340, 179}, {692, 112}, {787, 256}, {898, 296},},
		
		{{224,395}, {137,894}, {206,830}, {266,1067},},
		{{224,395}, {137,894}, {206,830}, {266,1067},},
		{{224,395}, {137,894}, {206,830}, {266,1067},},
		{{405,74}},
		{{405,74}},
		{{405,74}},
		{{405,74}},
		{{405,74}},
		{{405,74}},
		{{405,74}},
		
		{{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}},
		
		{{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}},
	},


	{ -- "A2" 2
		{},
		
		{{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }},
		
		{{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }},
		
		{{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}},
		
		{{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}},
		
		{{640,1437}},
		{{640,1437}},
		{{640,1437}},
		{{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
		{{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
		{{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
		{{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
		{{193,772}, {390,402}, {768,600}, {1075,789}, {1338,813},},
		{{193,772}, {390,402}, {768,600}, {1075,789}, {1338,813},},
	},



	{ -- "A3" 3
		{},

		{{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }},
		{{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }},

		{{ 948,804 }},
		{{ 948,804 }},
		{{ 948,804 }},
		{{438, 895}, {725, 864}, {632, 671},},
		{{438, 895}, {725, 864}, {632, 671},},
		{{438, 895}, {725, 864}, {632, 671},},
		{{438, 895}, {725, 864}, {632, 671},},
		{{438, 895}, {725, 864}, {632, 671},},
		{{847, 412}, {844, 854}, {823, 757}, {433, 407},},
		{{847, 412}, {844, 854}, {823, 757}, {433, 407},},
		{{847, 412}, {844, 854}, {823, 757}, {433, 407},},
		{{847, 412}, {844, 854}, {823, 757}, {433, 407},},
		{{847, 412}, {844, 854}, {823, 757}, {433, 407},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{316,168}, {497,130}, {701,157}, {858,316},},
		{{200,277}, {130,646}, {211,638}, {291,851},},
		{{200,277}, {130,646}, {211,638}, {291,851},},
		{{200,277}, {130,646}, {211,638}, {291,851},},
		{{100,150}},
		{{100,150}},
		{{100,150}},
		{{100,150}},
		{{100,150}},
		{{100,150}},
	},

	{}, -- 4
	{}, -- 5
	{}, -- 6
	{}, -- 7
	{}, -- 8
	{}, -- 9
	{}, -- 10
	{}, -- 11
	{}, -- 12
	{}, -- 13
	{}, -- 14
	{}, -- 15
	{}, -- 16
	{}, -- 17
	{}, -- 18
	{}, -- 19
	{}, -- 20

	{ -- "B1" 21
		{},
		
		{{412,635}, {629,428}, {829,586},},
		{{412,635}, {629,428}, {829,586},},
		{{412,635}, {629,428}, {829,586},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},
		{{329,643}, {632,349}, {905,556},},

		{{329,643}, {632,349}, {905,556},},
		{{866,822}, {706,224}, {247,722},},
		{{866,822}, {706,224}, {247,722},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
		{{617,948}, {353,221},},
	
		{{496,1089}, {890,1043},},
		{{496,1089}, {890,1043},},
		{{496,1089}, {890,1043},},
		{{876,1127}},
		{{876,1127}},
		{{876,1127}},
		{{876,1127}},
		{{876,1127}},
		{{876,1127}},
		{{876,1127}},
	
		{{876,1127}}, {{876,1127}}, {{876,1127}}, {{876,1127}}, {{876,1127}},	{{876,1127}},	{{876,1127}},	{{876,1127}},	{{876,1127}}, {{876,1127}},
		{{876,1127}}, {{876,1127}}, {{876,1127}}, {{908,87}},	{{908,87}},		{{908,87}},		{{908,87}},		{{908,87}},		{{908,87}},
	},

	{ -- "B2" 22
		{},

		{{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }},
		{{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }},
		{{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}},
		{{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}},

		{{746,1438}},
		{{746,1438}},
		{{746,1438}},
		{{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
		{{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
		{{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
		{{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
		{{787,235}, {1209,382}, {1350,571}, {1240,852}, {1254,1126}, {1078,1285}, {727,1360},},
		{{787,235}, {1209,382}, {1350,571}, {1240,852}, {1254,1126}, {1078,1285}, {727,1360},},
	},


	{ -- "B3" 23
		{},
		
		{{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }},
		{{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }},

		 {{ 106,88 }},
		{{ 106,88 }},
		{{ 106,88 }},
		{{230, 244}, {200, 444}, {594, 408},},
		{{230, 244}, {200, 444}, {594, 408},},
		{{230, 244}, {200, 444}, {594, 408},},
		{{230, 244}, {200, 444}, {594, 408},},
		{{230, 244}, {200, 444}, {594, 408},},
		{{584,204}, {720,376}, {861,272},},
		{{584,204}, {720,376}, {861,272},},
		{{584,204}, {720,376}, {861,272},},
		{{584,204}, {720,376}, {861,272},},
		{{584,204}, {720,376}, {861,272},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{566,694}, {349,574}, {198,645},},
		{{816,721}, {489,823},},
		{{816,721}, {489,823},},
		{{816,721}, {489,823},},
		{{772,140}},
		{{772,140}},
		{{772,140}},
		{{772,140}},
		{{772,140}},
		{{772,140}},
	},

	{}, -- 24
	{}, -- 25
	{}, -- 26
	{}, -- 27
	{}, -- 28
	{}, -- 29
	{}, -- 30
	{}, -- 31
	{}, -- 32
	{}, -- 33
	{}, -- 34
	{}, -- 35
	{}, -- 36
	{}, -- 37
	{}, -- 38
	{}, -- 39
	{}, -- 40

	{ -- "C1" 41
		{},

		{{385,446}, {169,592}, {211,692}, {632,681},},
		{{385,446}, {169,592}, {211,692}, {632,681},},
		{{385,446}, {169,592}, {211,692}, {632,681},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		{{385,374}, {227,815}, {664,771},},
		
		{{385,374}, {227,815}, {664,771},},
		{{169,362}, {368,304}, {626,409}, {187,882}, {571,858},},
		{{169,362}, {368,304}, {626,409}, {187,882}, {571,858},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		{{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
		
		{{452,160}, {536,1034}, {184,1044},},
		{{452,160}, {536,1034}, {184,1044},},
		{{452,160}, {536,1034}, {184,1044},},
		{{137,126}},
		{{137,126}},
		{{137,126}},
		{{137,126}},
		{{137,126}},
		{{137,126}},
		{{137,126}},
		
		{{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}},
		{{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}},
	},

	{ -- "C2" 42
		{},

		{{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
		{{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
		{{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
		{{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
	
		{{1409,139}},
		{{1409,139}},
		{{1409,139}},
		{{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
		{{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
		{{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
		{{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
		{{192,211}, {247,600}, {249,882}, {987,981}, {1018,1288}, {1303,1174},},
		{{192,211}, {247,600}, {249,882}, {987,981}, {1018,1288}, {1303,1174},},
	},

	{ -- "C3" 43
		{},

		{{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}},
		{{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}},
	
		{{901,151}},
		{{901,151}},
		{{901,151}},
		{{421, 189}, {167, 353},},
		{{421, 189}, {167, 353},},
		{{421, 189}, {167, 353},},
		{{421, 189}, {167, 353},},
		{{421, 189}, {167, 353},},
		{{679,459}, {505,709},},
		{{679,459}, {505,709},},
		{{679,459}, {505,709},},
		{{679,459}, {505,709},},
		{{679,459}, {505,709},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{858,638}, {234,596},},
		{{635,856}, {324,855},},
		{{635,856}, {324,855},},
		{{635,856}, {324,855},},
		{{136,899}},
		{{136,899}},
		{{136,899}},
		{{136,899}},
		{{136,899}},
		{{136,899}},
	},

	{}, -- 44
	{}, -- 45
	{}, -- 46
	{}, -- 47
	{}, -- 48
	{}, -- 49
	{}, -- 50
	{}, -- 51
	{}, -- 52
	{}, -- 53
	{}, -- 54
	{}, -- 55
	{}, -- 56
	{}, -- 57
	{}, -- 58
	{}, -- 59
	{}, -- 60
}

function BuildSkillList(job, group)
	local skill_vnum_list = {}
	local skill_name_list = {}

	if pc.get_skill_group() != 0 then
		local skill_list = special.active_skill_list[job+1][group]
				
		table.foreachi( skill_list,
			function(i, t)
				local lev = pc.get_skill_level(t)

				if lev > 0 then
					local name = locale.GM_SKILL_NAME_DICT[t]

					if name != nil then
						table.insert(skill_vnum_list, t)
						table.insert(skill_name_list, name)
					end
				end
			end
		)
	end

	table.insert(skill_vnum_list, 0)
	table.insert(skill_name_list, "Ãë¼Ò")

	return { skill_vnum_list, skill_name_list }
end

PREMIUM_EXP             = 0
PREMIUM_ITEM            = 1
PREMIUM_SAFEBOX         = 2
PREMIUM_AUTOLOOT        = 3
PREMIUM_FISH_MIND       = 4
PREMIUM_MARRIAGE_FAST   = 5
PREMIUM_GOLD            = 6

-- point type start
POINT_NONE                 = 0
POINT_LEVEL                = 1
POINT_VOICE                = 2
POINT_EXP                  = 3
POINT_NEXT_EXP             = 4
POINT_HP                   = 5
POINT_MAX_HP               = 6
POINT_SP                   = 7
POINT_MAX_SP               = 8  
POINT_STAMINA              = 9  --½ºÅ×¹Ì³Ê
POINT_MAX_STAMINA          = 10 --ÃÖ´ë ½ºÅ×¹Ì³Ê

POINT_GOLD                 = 11
POINT_ST                   = 12 --±Ù·Â
POINT_HT                   = 13 --Ã¼·Â
POINT_DX                   = 14 --¹ÎÃ¸¼º
POINT_IQ                   = 15 --Á¤½Å·Â
POINT_DEF_GRADE			= 16
POINT_ATT_SPEED            = 17 --°ø°Ý¼Óµµ
POINT_ATT_GRADE			= 18 --°ø°Ý·Â MAX
POINT_MOV_SPEED            = 19 --ÀÌµ¿¼Óµµ
POINT_CLIENT_DEF_GRADE		= 20 --¹æ¾îµî±Þ
POINT_CASTING_SPEED        = 21 --ÁÖ¹®¼Óµµ (Äð´Ù¿îÅ¸ÀÓ*100) / (100 + ÀÌ°ª) = ÃÖÁ¾ Äð´Ù¿î Å¸ÀÓ
POINT_MAGIC_ATT_GRADE      = 22 --¸¶¹ý°ø°Ý·Â
POINT_MAGIC_DEF_GRADE      = 23 --¸¶¹ý¹æ¾î·Â
POINT_EMPIRE_POINT         = 24 --Á¦±¹Á¡¼ö
POINT_LEVEL_STEP           = 25 --ÇÑ ·¹º§¿¡¼­ÀÇ ´Ü°è.. (1 2 3 µÉ ¶§ º¸»ó 4 µÇ¸é ·¹º§ ¾÷)
POINT_STAT                 = 26 --´É·ÂÄ¡ ¿Ã¸± ¼ö ÀÖ´Â °³¼ö
POINT_SUB_SKILL			= 27 --º¸Á¶ ½ºÅ³ Æ÷ÀÎÆ®
POINT_SKILL				= 28 --¾×Æ¼ºê ½ºÅ³ Æ÷ÀÎÆ®
POINT_WEAPON_MIN			= 29 --¹«±â ÃÖ¼Ò µ¥¹ÌÁö
POINT_WEAPON_MAX			= 30 --¹«±â ÃÖ´ë µ¥¹ÌÁö
POINT_PLAYTIME             = 31 --ÇÃ·¹ÀÌ½Ã°£
POINT_HP_REGEN             = 32 --HP È¸º¹·ü
POINT_SP_REGEN             = 33 --SP È¸º¹·ü

POINT_BOW_DISTANCE         = 34 --È° »çÁ¤°Å¸® Áõ°¡Ä¡ (meter)

POINT_HP_RECOVERY          = 35 --Ã¼·Â È¸º¹ Áõ°¡·®
POINT_SP_RECOVERY          = 36 --Á¤½Å·Â È¸º¹ Áõ°¡·®

POINT_POISON_PCT           = 37 --µ¶ È®·ü
POINT_STUN_PCT             = 38 --±âÀý È®·ü
POINT_SLOW_PCT             = 39 --½½·Î¿ì È®·ü
POINT_CRITICAL_PCT         = 40 --Å©¸®Æ¼ÄÃ È®·ü
POINT_PENETRATE_PCT        = 41 --°üÅëÅ¸°Ý È®·ü
POINT_CURSE_PCT            = 42 --ÀúÁÖ È®·ü

POINT_ATTBONUS_HUMAN       = 43 --ÀÎ°£¿¡°Ô °­ÇÔ
POINT_ATTBONUS_ANIMAL      = 44 --µ¿¹°¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_ORC         = 45 --¿õ±Í¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_MILGYO      = 46 --¹Ð±³¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_UNDEAD      = 47 --½ÃÃ¼¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_DEVIL       = 48 --¸¶±Í(¾Ç¸¶)¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_INSECT      = 49 --¹ú·¹Á·
POINT_ATTBONUS_FIRE        = 50 --È­¿°Á·
POINT_ATTBONUS_ICE         = 51 --ºù¼³Á·
POINT_ATTBONUS_DESERT      = 52 --»ç¸·Á·
POINT_ATTBONUS_MONSTER     = 53 --¸ðµç ¸ó½ºÅÍ¿¡°Ô °­ÇÔ
POINT_ATTBONUS_WARRIOR     = 54 --¹«»ç¿¡°Ô °­ÇÔ
POINT_ATTBONUS_ASSASSIN	= 55 --ÀÚ°´¿¡°Ô °­ÇÔ
POINT_ATTBONUS_SURA		= 56 --¼ö¶ó¿¡°Ô °­ÇÔ
POINT_ATTBONUS_SHAMAN		= 57 --¹«´ç¿¡°Ô °­ÇÔ

-- ADD_TRENT_MONSTER
POINT_ATTBONUS_TREE     	= 58 --³ª¹«¿¡°Ô °­ÇÔ 20050729.myevan UNUSED5 
-- END_OF_ADD_TRENT_MONSTER
POINT_RESIST_WARRIOR		= 59 --¹«»ç¿¡°Ô ÀúÇ×
POINT_RESIST_ASSASSIN		= 60 --ÀÚ°´¿¡°Ô ÀúÇ×
POINT_RESIST_SURA			= 61 --¼ö¶ó¿¡°Ô ÀúÇ×
POINT_RESIST_SHAMAN		= 62 --¹«´ç¿¡°Ô ÀúÇ×

POINT_STEAL_HP             = 63 --»ý¸í·Â Èí¼ö
POINT_STEAL_SP             = 64 --Á¤½Å·Â Èí¼ö

POINT_MANA_BURN_PCT        = 65 --¸¶³ª ¹ø

--/ ÇÇÇØ½Ã º¸³Ê½º =/

POINT_DAMAGE_SP_RECOVER    = 66 --°ø°Ý´çÇÒ ½Ã Á¤½Å·Â È¸º¹ È®·ü

POINT_BLOCK                = 67 --ºí·°À²
POINT_DODGE                = 68 --È¸ÇÇÀ²

POINT_RESIST_SWORD         = 69
POINT_RESIST_TWOHAND       = 70
POINT_RESIST_DAGGER        = 71
POINT_RESIST_BELL          = 72
POINT_RESIST_FAN           = 73
POINT_RESIST_BOW           = 74  --È­»ì   ÀúÇ×   : ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_FIRE          = 75  --È­¿°   ÀúÇ×   : È­¿°°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_ELEC          = 76  --Àü±â   ÀúÇ×   : Àü±â°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_MAGIC         = 77  --¼ú¹ý   ÀúÇ×   : ¸ðµç¼ú¹ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_WIND          = 78  --¹Ù¶÷   ÀúÇ×   : ¹Ù¶÷°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò

POINT_REFLECT_MELEE        = 79 --°ø°Ý ¹Ý»ç

--/ Æ¯¼ö ÇÇÇØ½Ã =/
POINT_REFLECT_CURSE		= 80 --ÀúÁÖ ¹Ý»ç
POINT_POISON_REDUCE		= 81 --µ¶µ¥¹ÌÁö °¨¼Ò

--/ Àû ¼Ò¸ê½Ã =/
POINT_KILL_SP_RECOVER		= 82 --Àû ¼Ò¸ê½Ã MP È¸º¹
POINT_EXP_DOUBLE_BONUS		= 83
POINT_GOLD_DOUBLE_BONUS		= 84
POINT_ITEM_DROP_BONUS		= 85

--/ È¸º¹ °ü·Ã =/
POINT_POTION_BONUS			= 86
POINT_KILL_HP_RECOVERY		= 87

POINT_IMMUNE_STUN			= 88
POINT_IMMUNE_SLOW			= 89
POINT_IMMUNE_FALL			= 90
--========

POINT_PARTY_ATTACKER_BONUS		= 91
POINT_PARTY_TANKER_BONUS		= 92

POINT_ATT_BONUS			= 93
POINT_DEF_BONUS			= 94

POINT_ATT_GRADE_BONUS		= 95
POINT_DEF_GRADE_BONUS		= 96
POINT_MAGIC_ATT_GRADE_BONUS	= 97
POINT_MAGIC_DEF_GRADE_BONUS	= 98

POINT_RESIST_NORMAL_DAMAGE		= 99

POINT_HIT_HP_RECOVERY		= 100
POINT_HIT_SP_RECOVERY 		= 101
POINT_MANASHIELD			= 102 --Èæ½Å¼öÈ£ ½ºÅ³¿¡ ÀÇÇÑ ¸¶³ª½¯µå È¿°ú Á¤µµ

POINT_PARTY_BUFFER_BONUS		= 103
POINT_PARTY_SKILL_MASTER_BONUS	= 104

POINT_HP_RECOVER_CONTINUE		= 105
POINT_SP_RECOVER_CONTINUE		= 106

POINT_STEAL_GOLD			= 107 
POINT_POLYMORPH			= 108 --º¯½ÅÇÑ ¸ó½ºÅÍ ¹øÈ£
POINT_MOUNT				= 109 --Å¸°íÀÖ´Â ¸ó½ºÅÍ ¹øÈ£

POINT_PARTY_HASTE_BONUS		= 110
POINT_PARTY_DEFENDER_BONUS		= 111
POINT_STAT_RESET_COUNT		= 112 --ÇÇÀÇ ´Ü¾à »ç¿ëÀ» ÅëÇÑ ½ºÅÝ ¸®¼Â Æ÷ÀÎÆ® (1´ç 1Æ÷ÀÎÆ® ¸®¼Â°¡´É)

POINT_HORSE_SKILL			= 113

POINT_MALL_ATTBONUS		= 114 --°ø°Ý·Â +x%
POINT_MALL_DEFBONUS		= 115 --¹æ¾î·Â +x%
POINT_MALL_EXPBONUS		= 116 --°æÇèÄ¡ +x%
POINT_MALL_ITEMBONUS		= 117 --¾ÆÀÌÅÛ µå·ÓÀ² x/10¹è
POINT_MALL_GOLDBONUS		= 118 --µ· µå·ÓÀ² x/10¹è

POINT_MAX_HP_PCT			= 119 --ÃÖ´ë»ý¸í·Â +x%
POINT_MAX_SP_PCT			= 120 --ÃÖ´ëÁ¤½Å·Â +x%

POINT_SKILL_DAMAGE_BONUS		= 121 --½ºÅ³ µ¥¹ÌÁö *(100+x)%
POINT_NORMAL_HIT_DAMAGE_BONUS	= 122 --ÆòÅ¸ µ¥¹ÌÁö *(100+x)%

-- DEFEND_BONUS_ATTRIBUTES
POINT_SKILL_DEFEND_BONUS		= 123 --½ºÅ³ ¹æ¾î µ¥¹ÌÁö
POINT_NORMAL_HIT_DEFEND_BONUS	= 124 --ÆòÅ¸ ¹æ¾î µ¥¹ÌÁö
-- END_OF_DEFEND_BONUS_ATTRIBUTES

-- PC_BANG_ITEM_ADD 
POINT_PC_BANG_EXP_BONUS		= 125 --PC¹æ Àü¿ë °æÇèÄ¡ º¸³Ê½º
POINT_PC_BANG_DROP_BONUS		= 126 --PC¹æ Àü¿ë µå·Ó·ü º¸³Ê½º
-- END_PC_BANG_ITEM_ADD
-- POINT_MAX_NUM = 128	common/length.h
-- point type start
