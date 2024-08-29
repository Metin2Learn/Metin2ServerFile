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

-- minimap에 동그라미 표시
function addmapsignal(x,y) raw_script("[ADDMAPSIGNAL x;"..x.."|y;"..y.."]") end

-- minimap 동그라미들 모두 클리어
function clearmapsignal() raw_script("[CLEARMAPSIGNAL]") end

-- 클라이언트에서 보여줄 대화창 배경 그림을 정한다.
function setbgimage(src) raw_script("[BGIMAGE src;") raw_script(src) raw_script("]") end

-- 대화창에 이미지를 보여준다.
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

function notice_multiline( str , func )
    local p = 0
    local i = 0
    while true do
        i = string.find( str, "%[ENTER%]", i+1 )
        if i == nil then
            if string.len(str) > p then
                func( string.sub( str, p, string.len(str) ) )
            end
            break
        end
        func( string.sub( str, p, i-1 ) )
        p = i + 7
    end
end 

function make_quest_button(name) makequestbutton(name) end

function send_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) setskin(NOWINDOW) q.set_title(name) q.start() end

function send_letter(name) makequestbutton(name) setskin(NOWINDOW) q.set_title(name) q.start() end
function clear_letter() q.done() end
function say_title(name) say(color256(255, 230, 186)..name..color256(200, 200, 200)) end
function say_reward(name) say(color256(255, 215, 0)..name..color256(200, 200, 200)) end
function say_pc_name() say(color256(255, 255, 255)..pc.get_name().." :"..color256(200, 200, 200)) end
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

function bitflags(bitfield, flagcount)
	local res = {}
	local flag = 0
	while flag < flagcount do
		local bit = math.mod(bitfield, 2)
		bitfield = math.floor(bitfield/2)
		table.insert(res, bit)
		flag = flag + 1
	end
	return res
end

function bitfield(bits)
	local res = 0
	local bitcount = table.getn(bits)
	for i = bitcount, 1, -1 do
		res = res + bits[i]*(2^(i-1))
	end
	return res
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
    local s=select("진행한다", "포기한다")
    if 2==s then 
	say(title.." 퀘스트를 정말로")
	say("포기하시겠습니까?")
	local s=select("네, 그렇습니다", "아닙니다")
	if 1==s then
	    say(title.."퀘스트를 포기했습니다")
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

function skill_group_dialog(e, j, g) -- e = 제국, j = 직업, g = 그룹
	e = 1 -- XXX 메시지가 나라별로 있다가 하나로 통합되었음
	

	-- 다른 직업이거나 다른 제국일 경우
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
			s = select(locale.horse_menu.revive, locale.horse_menu.ride, locale.horse_menu.unsummon, locale.horse_menu.close)
		else
			s = select(locale.horse_menu.feed, locale.horse_menu.ride, locale.horse_menu.unsummon, locale.horse_menu.close)
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
			-- do nothing
		end
	end
end

npc_index_table = {
    ['race'] = npc.getrace,
    ['empire'] = npc.get_empire,
    ['level'] = npc.get_level,
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

--coroutine을 이용한 선택항 처리
function select(...)
	return q.yield('select', arg)
end

areaname = {
	{"Youngan","Jayang","Jungrang"},
	{"Joan","Bokjung","Waryong"},
	{"Pyungmoo","Bakra","Imha"}
}

warp = {
	-- red c = 1
	{33420, 336280}, {11000, 363700},
	-- yellow c = 2
	{84557, 336079}, {62200, 363700},
	-- blue c = 3
	{33479, 336000},{113400, 363700}
}		
		
function select_table(table)
	return q.yield('select', table)
end

-- coroutine을 이용한 다음 엔터 기다리기
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

--전역 변수 접근과 관련된 계열
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

-- [esper] item types (plus some subtypes)
ITEM_NONE = 0
ITEM_WEAPON = 1
ITEM_ARMOR = 2

WEAPON_SWORD = 0
WEAPON_DAGGER = 1
WEAPON_BOW = 2
WEAPON_TWO_HANDED = 3
WEAPON_BELL = 4
WEAPON_FAN = 5
WEAPON_ARROW = 6
WEAPON_MOUNT_SPEAR = 7

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

-- 레벨업 퀘스트 -_-
special = {}

special.fortune_telling = 
{
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
	{1,	150000,	300000,	30027,	0,	0    },
	{2,	150000,	300000,	30028,	0,	0    },
	{3,	100000,	200000,	30034,	30018,	0    },
	{4,	100000,	200000,	30034,	30011,	0    },
	{5,	100000,	200000,	30011,	30034,	0    },
	{6,	100000,	200000,	27400,	0,	0    },
	{7,	200000,	400000,	30023,	30003,	0    },
	{8,	200000,	400000,	30005,	30033,	0    },
	{9,	200000,	800000,	30033,	30005,	0    },
	{10,	400000,	800000,	30021,	30033,	30045},
	{11,	400000,	800000,	30045,	30022,	30046},
	{12,	500000,	1200000,	30047,	30045,	30055},
	{13,	500000,	1200000,	30051,	30017,	30058},
	{14,	500000,	1200000,	30051,	30007,	30041},
	{15,	500000,	1500000,	30091,	30017,	30018},
	{16,	350000,	650000,	30021,	30033,	0    },
	{17,	400000,	900000,	30051,	30033,	0    },
	{18,	450000,	1000000,	30056,	30057,	30058},
	{19,	450000,	1000000,	30059,	30058,	30041},
	{20,	500000,	1500000,	0,	0,	0    },
}

special.active_skill_list = {
	{
		{ 1, 2, 3, 4, 5, 6},
		{ 16, 17, 18, 19, 20, 21},
	},
	{
		{31, 32, 33, 34, 35, 36},
		{46, 47, 48, 49, 50, 51},
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
	500,
	500,
	1000,
	1500,
	2000,
	2500,
	3000,
	4500,
	5000,
	7000,
	9000,
	11000,
	12500,
	14000,
	17500,
	22000,
	26000,
	28000,
	31000,
	35000,
	38000,
	40000,
	45000,
	50000,
	55000,
	60000,
	80000,
	90000,
	100000,
	110000,
	120000,
	130000,
	140000,
	150000,
	170000,
	190000,
	210000,
	230000,
	250000,
	275000,
	300000,
	325000,
	350000,
	375000,
	400000,
	425000,
	450000,
	475000,
	500000,
	550000,
	600000,
	650000,
	700000,
	750000,
	800000,
	850000,
	900000,
	950000,
	1000000,
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
    [134] = "wolf.tga",
    [135] = "wolf.tga",
    [174] = "wolf.tga",
    [175] = "wolf.tga",
    [176] = "wolf.tga",
    [178] = "wild_boar.tga",
    [179] = "wild_boar.tga",
    [180] = "bear.tga",
    [184] = "tiger.tga",

    [301] = "bak_inf.tga",
    [302] = "bak_gung.tga",
    [303] = "bak_gen1.tga",
    [304] = "bak_gen2.tga",

    [401] = "huk_inf.tga",
    [402] = "huk_dol.tga",
    [403] = "huk_gen1.tga",
    [404] = "huk_gen2.tga",
    [456] = "456.tga",
    [501] = "o_inf.tga",
    [502] = "o_jol.tga",
    [503] = "o_gung.tga",
    [504] = "o_jang.tga",

    [601] = "ung_inf.tga",
    [602] = "ung_chuk.tga",
    [603] = "ung_tu.tga",
    [631] = "ung_inf.tga",
    [632] = "ung_chuk.tga",
    [633] = "ung_tu.tga",

	[701] = "mil_chu.tga",
	[702] = "mil_na.tga",
	[703] = "mil_na.tga",
	[704] = "mil_na.tga",
	[706] = "756.tga",
	[707] = "756.tga",
	[735] = "mil_jip.tga",
	[756] = "756.tga",
	[757] = "757.tga",
	[776] = "776.tga",
	[777] = "777.tga",
	[901] = "sigwi.tga",
	[903] = "gwoijil.tga",
	[932] = "932.tga",
	[933] = "gwoijil.tga",
	[934] = "934.tga",
	[935] = "935.tga",
	[936] = "936.tga",
	[937] = "937.tga",
	[1001] = "1001.tga",
	[1002] = "1002.tga",
	[1003] = "1003.tga",
	[1004] = "1004.tga",
	[1061] = "1061.tga",
	[1063] = "1063.tga",
	[1064] = "1064.tga",
	[1065] = "1065.tga",
	[1066] = "1066.tga",
	[1068] = "1068.tga",
	[1069] = "1069.tga",
	[1070] = "1065.tga",
	[1071] = "1065.tga",
	[1101] = "1101.tga",
	[1102] = "1102.tga",
	[1103] = "1133.tga",
	[1104] = "1104.tga",
	[1105] = "1105.tga",
	[1106] = "1106.tga",
	[1107] = "1107.tga",
	[1131] = "1131.tga",
	[1132] = "1132.tga",
	[1133] = "1133.tga",
	[1134] = "1104.tga",
	[1135] = "1135.tga",
	[1136] = "1136.tga",
	[1137] = "1137.tga",
	[1301] = "1301.tga",
	[1303] = "1303.tga",
	[1305] = "1305.tga",
	[2001] = "spider.tga",
	[2002] = "spider.tga",
	[2003] = "spider.tga",
	[2004] = "spider.tga",
	[2005] = "spider.tga",
	[2031] = "2031.tga",
	[2032] = "2032.tga",
	[2033] = "2033.tga",
	[2034] = "2034.tga",
	[2061] = "2061.tga",
	[2062] = "2062.tga",
	[2063] = "2063.tga",
	[2102] = "2102.tga",
	[2103] = "2103.tga",
	[2106] = "2106.tga",
	[2131] = "2131.tga",
	[2158] = "2158.tga",
	[2201] = "2201.tga",
	[2202] = "2202.tga",
	[2204] = "2203.tga",
	[2205] = "2205.tga",
	[2301] = "2301.tga",
	[2302] = "2302.tga",
	[2303] = "2303.tga",
	[2304] = "2304.tga",
	[2305] = "2305.tga",
	[2311] = "2311.tga",
	[2312] = "2312.tga",
	[2313] = "2313.tga",
	[2314] = "2314.tga",
	[2315] = "2315.tga",
	[5123] = "5123.tga",
	[5124] = "5124.tga",
	[5125] = "5125.tga",
	[5126] = "5126.tga",

}

special.levelup_quest = {
    -- monster kill  monster   kill
    --    vnum		qty.		 vnum		qty.	 exp percent
{	0	,	0	,	0	,	0	,	0	}	,	--	lev	1
{	101	,	7	,	102	,	3	,	"30-40"	}	,	--	lev	2
{	101	,	8	,	102	,	6	,	"30-40"	}	,	--	lev	3
{	102	,	6	,	103	,	4	,	"30-40"	}	,	--	lev	4
{	103	,	6	,	174	,	6	,	"30-40"	}	,	--	lev	5
{	174	,	8	,	178	,	6	,	"30-40"	}	,	--	lev	6
{	178	,	6	,	105	,	4	,	"30-40"	}	,	--	lev	7
{	178	,	8	,	105	,	6	,	"30-40"	}	,	--	lev	8
{	105	,	8	,	179	,	4	,	"30-40"	}	,	--	lev	9
{	105	,	8	,	179	,	4	,	"30-40"	}	,	--	lev	10
{	179	,	8	,	180	,	4	,	"30-40"	}	,	--	lev	11
{	180	,	10	,	175	,	10	,	"30-40"	}	,	--	lev	12
{	175	,	10	,	111	,	5	,	"30-40"	}	,	--	lev	13
{	111	,	10	,	176	,	5	,	"30-40"	}	,	--	lev	14
{	111	,	15	,	176	,	10	,	"30-40"	}	,	--	lev	15
{	136	,	5	,	184	,	5	,	"30-40"	}	,	--	lev	16
{	136	,	10	,	184	,	10	,	"30-40"	}	,	--	lev	17
{	184	,	10	,	112	,	10	,	"30-40"	}	,	--	lev	18
{	112	,	15	,	113	,	10	,	"30-40"	}	,	--	lev	19
{	113	,	20	,	302	,	15	,	"30-40"	}	,	--	lev	20
{	302	,	20	,	115	,	10	,	"30-40"	}	,	--	lev	21
{	115	,	25	,	304	,	10	,	"30-40"	}	,	--	lev	22
{	304	,	20	,	401	,	20	,	"30-40"	}	,	--	lev	23
{	401	,	20	,	402	,	30	,	"30-40"	}	,	--	lev	24
{	501	,	25	,	404	,	20	,	"30-40"	}	,	--	lev	25
{	502	,	35	,	406	,	15	,	"30-40"	}	,	--	lev	26
{	406	,	25	,	504	,	20	,	"30-40"	}	,	--	lev	27
{	631	,	25	,	504	,	25	,	"30-40"	}	,	--	lev	28
{	631	,	25	,	632	,	25	,	"30-40"	}	,	--	lev	29
{	632	,	25	,	2102	,	25	,	"30-40"	}	,	--	lev	30
{	632	,	35	,	2102	,	40	,	"20-26"	}	,	--	lev	31
{	633	,	30	,	2001	,	35	,	"20-26"	}	,	--	lev	32
{	701	,	25	,	2103	,	25	,	"20-26"	}	,	--	lev	33
{	701	,	30	,	2103	,	35	,	"20-26"	}	,	--	lev	34
{	702	,	25	,	2002	,	25	,	"20-26"	}	,	--	lev	35
{	704	,	20	,	2106	,	20	,	"20-26"	}	,	--	lev	36
{	733	,	25	,	2003	,	20	,	"20-26"	}	,	--	lev	37
{	734	,	30	,	2004	,	20	,	"20-26"	}	,	--	lev	38
{	706	,	30	,	2005	,	30	,	"20-26"	}	,	--	lev	39
{	707	,	30	,	2108	,	20	,	"20-26"	}	,	--	lev	40
{	901	,	35	,	5123	,	25	,	"15-21"	}	,	--	lev	41
{	902	,	30	,	5123	,	30	,	"15-21"	}	,	--	lev	42
{	902	,	35	,	2031	,	35	,	"15-21"	}	,	--	lev	43
{	933	,	35	,	2031	,	35	,	"15-21"	}	,	--	lev	44
{	731	,	35	,	2032	,	40	,	"15-21"	}	,	--	lev	45
{	732	,	30	,	5124	,	30	,	"15-21"	}	,	--	lev	46
{	933	,	35	,	5125	,	30	,	"15-21"	}	,	--	lev	47
{	904	,	40	,	5125	,	35	,	"15-21"	}	,	--	lev	48
{	733	,	35	,	2033	,	40	,	"15-21"	}	,	--	lev	49
{	734	,	40	,	5126	,	20	,	"15-21"	}	,	--	lev	50
{	735	,	50	,	5126	,	30	,	"10-16"	}	,	--	lev	51
{	904	,	45	,	2034	,	40	,	"10-16"	}	,	--	lev	52
{	904	,	50	,	2034	,	50	,	"10-16"	}	,	--	lev	53
{	736	,	40	,	1001	,	30	,	"10-16"	}	,	--	lev	54
{	737	,	40	,	1301	,	35	,	"10-16"	}	,	--	lev	55
{	905	,	50	,	1002	,	30	,	"10-16"	}	,	--	lev	56
{	905	,	50	,	1002	,	30	,	"10-16"	}	,	--	lev	57
{	906	,	35	,	1303	,	30	,	"10-16"	}	,	--	lev	58
{	906	,	50	,	1303	,	45	,	"10-16"	}	,	--	lev	59
{	907	,	45	,	1003	,	40	,	"10-16"	}	,	--	lev	60
{	1004	,	55	,	2061	,	60	,	"8-16"	}	,	--	lev	61
{	1305	,	45	,	2131	,	55	,	"8-16"	}	,	--	lev	62
{	1305	,	50	,	1101	,	45	,	"8-16"	}	,	--	lev	63
{	2062	,	50	,	1102	,	45	,	"8-16"	}	,	--	lev	64
{	1104	,	40	,	2063	,	40	,	"8-16"	}	,	--	lev	65
{	2301	,	50	,	1105	,	45	,	"8-16"	}	,	--	lev	66
{	2301	,	55	,	1105	,	50	,	"8-16"	}	,	--	lev	67
{	1106	,	50	,	1031	,	50	,	"8-16"	}	,	--	lev	68
{	1107	,	45	,	1031	,	50	,	"8-16"	}	,	--	lev	69
{	2302	,	55	,	2201	,	55	,	"8-16"	}	,	--	lev	70
{	2303	,	55	,	2202	,	55	,	"5-10"	}	,	--	lev	71
{	2303	,	60	,	2202	,	60	,	"5-10"	}	,	--	lev	72
{	2304	,	55	,	2201	,	55	,	"5-10"	}	,	--	lev	73
{	2305	,	50	,	1063	,	55	,	"5-10"	}	,	--	lev	74
{	2204	,	50	,	1063	,	50	,	"5-10"	}	,	--	lev	75
{	2305	,	45	,	1065	,	50	,	"5-10"	}	,	--	lev	76
{	2315	,	40	,	1065	,	50	,	"5-10"	}	,	--	lev	77
{	1070	,	50	,	1066	,	55	,	"5-10"	}	,	--	lev	78
{	1069	,	50	,	1070	,	50	,	"5-10"	}	,	--	lev	79
{	1071	,	50	,	2312	,	55	,	"5-10"	}	,	--	lev	80
{	1071	,	50	,	2312	,	55	,	"5-10"	}	,	--	lev	81
{	2313	,	50	,	2314	,	40	,	"5-10"	}	,	--	lev	82
{	2313	,	60	,	2314	,	45	,	"5-10"	}	,	--	lev	83
{	1131	,	60	,	2315	,	50	,	"5-10"	}	,	--	lev	84
{	1132	,	60	,	2315	,	45	,	"5-10"	}	,	--	lev	85
{	1132	,	60	,	1135	,	50	,	"5-10"	}	,	--	lev	86
{	1132	,	60	,	1135	,	50	,	"5-10"	}	,	--	lev	87
{	1133	,	60	,	1136	,	50	,	"5-10"	}	,	--	lev	88
{	1133	,	60	,	1137	,	50	,	"5-10"	}	,	--	lev	89
{	1133	,	60	,	1137	,	50	,	"5-10"	}	,	--	lev	90

}

special.levelup_reward1 = 
{
	-- warrior assassin  sura  shaman
	{     0,        0,      0,      0 },
	{ 11203,    11403,  11603,  11803 }, -- 갑옷 lev2
	{ 12203,    12343,  12483,  12623 }, -- 투구 lev3
	{ 13003,    13003,  13003,  13003 }  -- 방패 lev4
}

-- levelup_reward1 테이블 크기보다 레벨이 높아지면 아래
-- 테이블을 이용하여 아이템을 준다.
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
    { 40000,	20 },
    { 80000,	40 },
    { 120000,	25 },
    { 160000,	10 },
    { 200000,	5 },
}
special.levelup_reward_gold41 =
{
    { 80000,	20 },
    { 120000,	40 },
    { 160000,	25 },
    { 200000,	10 },
    { 300000,	5 },
}
special.levelup_reward_gold51 =
{
    { 120000,	20 },
    { 160000,	40 },
    { 200000,	25 },
    { 300000,	10 },
    { 400000,	5 },
}
special.levelup_reward_gold61 =
{
    { 160000,	20 },
    { 200000,	40 },
    { 300000,	25 },
    { 400000,	10 },
    { 500000,	5 },
}
special.levelup_reward_gold71 =
{
    { 200000,	20 },
    { 500000,	40 },
    { 800000,	25 },
    { 1000000,	10 },
    { 2000000,	5 },
}
special.levelup_reward_gold84 =
{
    { 400000,	20 },
    { 1000000,	40 },
    { 1600000,	25 },
    { 3200000,	10 },
    { 4000000,	5 },
}

special.levelup_reward_exp21 =
{
    { 30,	9 },
    { 32,	14 },
    { 34,	39 },
    { 36,	24 },
    { 38,	9 },
    { 40,	4 },
}

special.levelup_reward_exp31 = 
{
    { 20,	10 },
    { 21,	15 },
    { 22,	40 },
    { 23,	25 },
    { 24,	8 },
    { 25,	5 },
    { 26,	2 },
}
special.levelup_reward_exp41 = 
{
    { 15,	10 },
    { 16,	15 },
    { 17,	40 },
    { 18,	25 },
    { 19,	8 },
    { 20,	5 },
    { 21,	2 },
}
special.levelup_reward_exp51 = 
{
    { 10,	10 },
    { 11,	15 },
    { 12,	40 },
    { 13,	25 },
    { 14,	8 },
    { 15,	5 },
    { 16,	2 },
}

special.levelup_reward_exp61 = 
{
    { 8,	40 },
    { 10,	20 },
    { 12,	18 },
    { 14,	15 },
    { 16,	5 },
}

special.levelup_reward_exp84 = 
{
    { 5,	10 },
    { 6,	20 },
    { 7,	25 },
    { 8,	20 },
    { 9,	20 },
    { 10,	5 },
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
-- 승룡곡
    {
	{ 402100, 673900 }, 
	{ 270400, 739900 },
	{ 321300, 808000 },
    },
--도염화지
    {
--A 5994 7563 
--B 5978 6222
--C 7307 6898
	{ 599400, 756300 },
	{ 597800, 622200 },
	{ 730700, 689800 },
    },
--영비사막
    {
--A 2178 6272
	{ 217800, 627200 },
--B 2219 5027
	{ 221900, 502700 },
--C 3440 5025
	{ 344000, 502500 },
    },
--서한산
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

dta_warp = {
	{20176, 71330, 122270},
	{358295, 358281, 358264},
	{33163, 84351, 135486},
	{336535, 336509, 336585},
}

dta_keywords = {
	{"DUNGEON", 90056, 90073, 90066, 90059, 90057, 90067, 90066, "D U N"},
	{"ALCHEMY", 90053, 90064, 90055, 90060, 90057, 90065, 90077, "A L C"},
	{"WARRIOR", 90075, 90053, 90070, 90070, 90061, 90067, 90070, "W A R"},
	{"BIOLOGY", 90054, 90061, 90067, 90064, 90067, 90059, 90077, "B I O"},
	{"CAPTAIN", 90055, 90053, 90068, 90072, 90053, 90061, 90066, "C A P"},
	{"WARLORD", 90075, 90053, 90070, 90064, 90067, 90070, 90056, "W A R"},
	{"STAMINA", 90071, 90072, 90053, 90065, 90061, 90066, 90053, "S T A"},
	{"EARRING", 90057, 90053, 90070, 90070, 90061, 90066, 90059, "E A R"},
	{"DEFENSE", 90056, 90057, 90058, 90057, 90066, 90071, 90057, "D E F"},
	{"BERSERK", 90054, 90057, 90070, 90071, 90057, 90070, 90063, "B E R"},
	{"KINGDOM", 90063, 90061, 90066, 90059, 90056, 90067, 90065, "K I N"},
	{"WIZARDS", 90075, 90061, 90078, 90053, 90070, 90056, 90071, "W I Z"},
	{"STEALTH", 90071, 90072, 90057, 90053, 90064, 90072, 90060, "S T E"},
	{"FARMING", 90058, 90053, 90070, 90065, 90061, 90066, 90059, "F A R"},
	{"FISHING", 90058, 90061, 90071, 90060, 90061, 90066, 90059, "F I S"},
	{"SUCCESS", 90071, 90073, 90055, 90055, 90057, 90071, 90071, "S U C"},
	{"FAILURE", 90058, 90053, 90061, 90064, 90073, 90070, 90057, "F A I"},
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
	table.insert(skill_name_list, locale.cancel)

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
POINT_STAMINA              = 9  --스테미너
POINT_MAX_STAMINA          = 10 --최대 스테미너

POINT_GOLD                 = 11
POINT_ST                   = 12 --근력
POINT_HT                   = 13 --체력
POINT_DX                   = 14 --민첩성
POINT_IQ                   = 15 --정신력
POINT_DEF_GRADE			= 16
POINT_ATT_SPEED            = 17 --공격속도
POINT_ATT_GRADE			= 18 --공격력 MAX
POINT_MOV_SPEED            = 19 --이동속도
POINT_CLIENT_DEF_GRADE		= 20 --방어등급
POINT_CASTING_SPEED        = 21 --주문속도 (쿨다운타임*100) / (100 + 이값) = 최종 쿨다운 타임
POINT_MAGIC_ATT_GRADE      = 22 --마법공격력
POINT_MAGIC_DEF_GRADE      = 23 --마법방어력
POINT_EMPIRE_POINT         = 24 --제국점수
POINT_LEVEL_STEP           = 25 --한 레벨에서의 단계.. (1 2 3 될 때 보상 4 되면 레벨 업)
POINT_STAT                 = 26 --능력치 올릴 수 있는 개수
POINT_SUB_SKILL			= 27 --보조 스킬 포인트
POINT_SKILL				= 28 --액티브 스킬 포인트
POINT_WEAPON_MIN			= 29 --무기 최소 데미지
POINT_WEAPON_MAX			= 30 --무기 최대 데미지
POINT_PLAYTIME             = 31 --플레이시간
POINT_HP_REGEN             = 32 --HP 회복률
POINT_SP_REGEN             = 33 --SP 회복률

POINT_BOW_DISTANCE         = 34 --활 사정거리 증가치 (meter)

POINT_HP_RECOVERY          = 35 --체력 회복 증가량
POINT_SP_RECOVERY          = 36 --정신력 회복 증가량

POINT_POISON_PCT           = 37 --독 확률
POINT_STUN_PCT             = 38 --기절 확률
POINT_SLOW_PCT             = 39 --슬로우 확률
POINT_CRITICAL_PCT         = 40 --크리티컬 확률
POINT_PENETRATE_PCT        = 41 --관통타격 확률
POINT_CURSE_PCT            = 42 --저주 확률

POINT_ATTBONUS_HUMAN       = 43 --인간에게 강함
POINT_ATTBONUS_ANIMAL      = 44 --동물에게 데미지 % 증가
POINT_ATTBONUS_ORC         = 45 --웅귀에게 데미지 % 증가
POINT_ATTBONUS_MILGYO      = 46 --밀교에게 데미지 % 증가
POINT_ATTBONUS_UNDEAD      = 47 --시체에게 데미지 % 증가
POINT_ATTBONUS_DEVIL       = 48 --마귀(악마)에게 데미지 % 증가
POINT_ATTBONUS_INSECT      = 49 --벌레족
POINT_ATTBONUS_FIRE        = 50 --화염족
POINT_ATTBONUS_ICE         = 51 --빙설족
POINT_ATTBONUS_DESERT      = 52 --사막족
POINT_ATTBONUS_MONSTER     = 53 --모든 몬스터에게 강함
POINT_ATTBONUS_WARRIOR     = 54 --무사에게 강함
POINT_ATTBONUS_ASSASSIN	= 55 --자객에게 강함
POINT_ATTBONUS_SURA		= 56 --수라에게 강함
POINT_ATTBONUS_SHAMAN		= 57 --무당에게 강함

-- ADD_TRENT_MONSTER
POINT_ATTBONUS_TREE     	= 58 --나무에게 강함 20050729.myevan UNUSED5 
-- END_OF_ADD_TRENT_MONSTER
POINT_RESIST_WARRIOR		= 59 --무사에게 저항
POINT_RESIST_ASSASSIN		= 60 --자객에게 저항
POINT_RESIST_SURA			= 61 --수라에게 저항
POINT_RESIST_SHAMAN		= 62 --무당에게 저항

POINT_STEAL_HP             = 63 --생명력 흡수
POINT_STEAL_SP             = 64 --정신력 흡수

POINT_MANA_BURN_PCT        = 65 --마나 번

--/ 피해시 보너스 =/

POINT_DAMAGE_SP_RECOVER    = 66 --공격당할 시 정신력 회복 확률

POINT_BLOCK                = 67 --블럭율
POINT_DODGE                = 68 --회피율

POINT_RESIST_SWORD         = 69
POINT_RESIST_TWOHAND       = 70
POINT_RESIST_DAGGER        = 71
POINT_RESIST_BELL          = 72
POINT_RESIST_FAN           = 73
POINT_RESIST_BOW           = 74  --화살   저항   : 대미지 감소
POINT_RESIST_FIRE          = 75  --화염   저항   : 화염공격에 대한 대미지 감소
POINT_RESIST_ELEC          = 76  --전기   저항   : 전기공격에 대한 대미지 감소
POINT_RESIST_MAGIC         = 77  --술법   저항   : 모든술법에 대한 대미지 감소
POINT_RESIST_WIND          = 78  --바람   저항   : 바람공격에 대한 대미지 감소

POINT_REFLECT_MELEE        = 79 --공격 반사

--/ 특수 피해시 =/
POINT_REFLECT_CURSE		= 80 --저주 반사
POINT_POISON_REDUCE		= 81 --독데미지 감소

--/ 적 소멸시 =/
POINT_KILL_SP_RECOVER		= 82 --적 소멸시 MP 회복
POINT_EXP_DOUBLE_BONUS		= 83
POINT_GOLD_DOUBLE_BONUS		= 84
POINT_ITEM_DROP_BONUS		= 85

--/ 회복 관련 =/
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
POINT_MANASHIELD			= 102 --흑신수호 스킬에 의한 마나쉴드 효과 정도

POINT_PARTY_BUFFER_BONUS		= 103
POINT_PARTY_SKILL_MASTER_BONUS	= 104

POINT_HP_RECOVER_CONTINUE		= 105
POINT_SP_RECOVER_CONTINUE		= 106

POINT_STEAL_GOLD			= 107 
POINT_POLYMORPH			= 108 --변신한 몬스터 번호
POINT_MOUNT				= 109 --타고있는 몬스터 번호

POINT_PARTY_HASTE_BONUS		= 110
POINT_PARTY_DEFENDER_BONUS		= 111
POINT_STAT_RESET_COUNT		= 112 --피의 단약 사용을 통한 스텟 리셋 포인트 (1당 1포인트 리셋가능)

POINT_HORSE_SKILL			= 113

POINT_MALL_ATTBONUS		= 114 --공격력 +x%
POINT_MALL_DEFBONUS		= 115 --방어력 +x%
POINT_MALL_EXPBONUS		= 116 --경험치 +x%
POINT_MALL_ITEMBONUS		= 117 --아이템 드롭율 x/10배
POINT_MALL_GOLDBONUS		= 118 --돈 드롭율 x/10배

POINT_MAX_HP_PCT			= 119 --최대생명력 +x%
POINT_MAX_SP_PCT			= 120 --최대정신력 +x%

POINT_SKILL_DAMAGE_BONUS		= 121 --스킬 데미지 *(100+x)%
POINT_NORMAL_HIT_DAMAGE_BONUS	= 122 --평타 데미지 *(100+x)%

-- DEFEND_BONUS_ATTRIBUTES
POINT_SKILL_DEFEND_BONUS		= 123 --스킬 방어 데미지
POINT_NORMAL_HIT_DEFEND_BONUS	= 124 --평타 방어 데미지
-- END_OF_DEFEND_BONUS_ATTRIBUTES

-- PC_BANG_ITEM_ADD 
POINT_PC_BANG_EXP_BONUS		= 125 --PC방 전용 경험치 보너스
POINT_PC_BANG_DROP_BONUS		= 126 --PC방 전용 드롭률 보너스
-- END_PC_BANG_ITEM_ADD
-- POINT_MAX_NUM = 128	common/length.h
-- point type start

get_mob_level =
	{
		[2051] = 65,
		[2052] = 67,
		[2053] = 69,
		[2054] = 71,
		[2055] = 73,
		[11116] = 90,
		[2061] = 60,
		[2062] = 62,
		[2063] = 64,
		[2064] = 66,
		[2065] = 68,
		[2071] = 70,
		[2072] = 72,
		[2073] = 74,
		[2074] = 76,
		[2075] = 78,
		[2076] = 78,
		[11117] = 90,
		[2091] = 60,
		[2092] = 79,
		[2093] = 65,
		[2094] = 72,
		[2095] = 70,
		[2101] = 19,
		[2102] = 37,
		[2103] = 39,
		[2104] = 44,
		[2105] = 47,
		[2106] = 48,
		[2107] = 51,
		[2108] = 54,
		[5131] = 22,
		[2401] = 87,
		[5132] = 25,
		[2402] = 89,
		[5133] = 27,
		[2131] = 60,
		[2132] = 62,
		[2133] = 64,
		[2134] = 66,
		[2135] = 68,
		[101] = 1,
		[102] = 3,
		[103] = 4,
		[2152] = 37,
		[105] = 9,
		[106] = 13,
		[107] = 16,
		[108] = 7,
		[109] = 10,
		[110] = 12,
		[111] = 15,
		[112] = 19,
		[113] = 21,
		[114] = 18,
		[115] = 24,
		[5141] = 35,
		[131] = 8,
		[132] = 9,
		[133] = 11,
		[134] = 14,
		[135] = 18,
		[136] = 21,
		[137] = 12,
		[138] = 15,
		[139] = 17,
		[140] = 20,
		[141] = 24,
		[142] = 26,
		[143] = 24,
		[144] = 29,
		[151] = 9,
		[152] = 16,
		[153] = 10,
		[154] = 21,
		[2203] = 70,
		[2204] = 71,
		[2205] = 72,
		[2206] = 73,
		[2207] = 78,
		[171] = 1,
		[172] = 3,
		[173] = 4,
		[174] = 6,
		[175] = 9,
		[2224] = 71,
		[177] = 16,
		[178] = 7,
		[179] = 10,
		[180] = 12,
		[181] = 15,
		[182] = 19,
		[183] = 21,
		[184] = 18,
		[185] = 24,
		[2234] = 71,
		[2235] = 72,
		[191] = 30,
		[192] = 31,
		[193] = 33,
		[194] = 35,
		[5153] = 49,
		[5157] = 54,
		[2291] = 75,
		[2292] = 99,
		[2293] = 99,
		[5161] = 30,
		[2301] = 65,
		[2302] = 67,
		[2303] = 69,
		[2304] = 70,
		[2305] = 71,
		[2306] = 84,
		[2307] = 86,
		[2311] = 74,
		[2312] = 76,
		[2313] = 77,
		[2314] = 80,
		[2315] = 82,
		[301] = 18,
		[302] = 20,
		[303] = 25,
		[304] = 25,
		[8501] = 35,
		[8502] = 30,
		[8503] = 25,
		[8504] = 5,
		[8505] = 10,
		[8506] = 12,
		[8507] = 15,
		[8508] = 20,
		[8509] = 25,
		[8510] = 21,
		[8511] = 11,
		[331] = 18,
		[332] = 20,
		[333] = 25,
		[334] = 25,
		[351] = 18,
		[352] = 20,
		[353] = 25,
		[354] = 25,
		[2403] = 89,
		[2404] = 90,
		[2411] = 91,
		[2412] = 93,
		[2413] = 95,
		[2414] = 97,
		[2451] = 84,
		[5127] = 54,
		[2452] = 86,
		[2431] = 80,
		[2432] = 82,
		[2433] = 82,
		[2434] = 83,
		[2454] = 90,
		[391] = 23,
		[392] = 26,
		[393] = 28,
		[394] = 31,
		[395] = 23,
		[396] = 26,
		[397] = 28,
		[398] = 31,
		[401] = 26,
		[402] = 27,
		[403] = 29,
		[404] = 30,
		[405] = 33,
		[406] = 35,
		[8600] = 73,
		[8601] = 86,
		[8602] = 73,
		[8603] = 86,
		[8604] = 73,
		[8605] = 86,
		[8606] = 73,
		[8607] = 86,
		[8608] = 73,
		[8609] = 86,
		[8610] = 73,
		[8611] = 86,
		[8612] = 73,
		[8613] = 86,
		[8614] = 73,
		[8615] = 86,
		[8616] = 86,
		[11108] = 70,
		[431] = 31,
		[432] = 33,
		[433] = 35,
		[434] = 36,
		[435] = 38,
		[436] = 40,
		[2491] = 93,
		[2492] = 95,
		[2493] = 97,
		[2494] = 88,
		[2495] = 90,
		[451] = 26,
		[452] = 27,
		[453] = 29,
		[454] = 30,
		[455] = 33,
		[456] = 35,
		[2505] = 83,
		[2506] = 84,
		[2507] = 85,
		[2508] = 79,
		[2509] = 80,
		[2510] = 81,
		[2511] = 82,
		[2512] = 83,
		[2513] = 84,
		[2514] = 86,
		[1175] = 65,
		[491] = 32,
		[492] = 37,
		[493] = 39,
		[494] = 45,
		[2543] = 81,
		[2544] = 82,
		[2545] = 83,
		[2546] = 84,
		[2547] = 86,
		[501] = 29,
		[502] = 32,
		[503] = 35,
		[504] = 36,
		[531] = 35,
		[532] = 37,
		[533] = 40,
		[534] = 42,
		[2591] = 89,
		[2592] = 89,
		[2593] = 89,
		[2594] = 89,
		[2595] = 89,
		[2596] = 89,
		[2597] = 91,
		[2598] = 91,
		[551] = 29,
		[552] = 32,
		[553] = 35,
		[554] = 36,
		[2482] = 92,
		[2483] = 94,
		[2484] = 96,
		[5134] = 29,
		[591] = 42,
		[595] = 42,
		[601] = 26,
		[602] = 29,
		[603] = 31,
		[604] = 33,
		[2151] = 19,
		[104] = 6,
		[631] = 34,
		[632] = 36,
		[633] = 39,
		[634] = 40,
		[635] = 44,
		[636] = 46,
		[637] = 49,
		[2155] = 47,
		[2156] = 48,
		[651] = 34,
		[652] = 36,
		[653] = 39,
		[654] = 40,
		[2157] = 51,
		[656] = 46,
		[657] = 49,
		[2158] = 54,
		[2501] = 79,
		[2502] = 80,
		[2503] = 81,
		[5001] = 10,
		[2504] = 82,
		[691] = 50,
		[692] = 55,
		[693] = 60,
		[701] = 35,
		[702] = 38,
		[703] = 41,
		[704] = 44,
		[705] = 48,
		[706] = 49,
		[707] = 51,
		[731] = 52,
		[732] = 53,
		[733] = 54,
		[734] = 54,
		[735] = 55,
		[736] = 56,
		[737] = 57,
		[751] = 35,
		[752] = 38,
		[753] = 41,
		[754] = 44,
		[755] = 48,
		[756] = 49,
		[757] = 51,
		[771] = 52,
		[772] = 53,
		[773] = 54,
		[774] = 54,
		[775] = 55,
		[776] = 56,
		[777] = 57,
		[7050] = 35,
		[2481] = 91,
		[791] = 54,
		[792] = 62,
		[793] = 64,
		[794] = 72,
		[795] = 54,
		[796] = 62,
		[7051] = 31,
		[7001] = 52,
		[7002] = 53,
		[2191] = 67,
		[7004] = 54,
		[7005] = 55,
		[7006] = 56,
		[7007] = 56,
		[7008] = 52,
		[2192] = 72,
		[7010] = 54,
		[11107] = 70,
		[7012] = 52,
		[7013] = 53,
		[7014] = 54,
		[7015] = 54,
		[7016] = 55,
		[7017] = 56,
		[7018] = 56,
		[7019] = 59,
		[7020] = 59,
		[7021] = 60,
		[7022] = 61,
		[7023] = 62,
		[7024] = 64,
		[7025] = 66,
		[7026] = 67,
		[7027] = 70,
		[7028] = 72,
		[7029] = 35,
		[7030] = 31,
		[7031] = 33,
		[7032] = 35,
		[7033] = 36,
		[7034] = 38,
		[7035] = 40,
		[7036] = 52,
		[7037] = 53,
		[7038] = 54,
		[7039] = 54,
		[7040] = 55,
		[7041] = 56,
		[7042] = 57,
		[7043] = 81,
		[7044] = 81,
		[901] = 49,
		[902] = 51,
		[903] = 53,
		[904] = 55,
		[905] = 58,
		[906] = 58,
		[907] = 59,
		[5004] = 80,
		[5005] = 85,
		[7054] = 36,
		[2541] = 79,
		[7056] = 40,
		[7057] = 52,
		[7058] = 53,
		[7059] = 54,
		[7060] = 54,
		[2542] = 80,
		[7062] = 56,
		[2201] = 69,
		[7064] = 81,
		[7065] = 81,
		[7066] = 82,
		[7067] = 83,
		[7068] = 83,
		[2202] = 69,
		[7070] = 85,
		[7071] = 33,
		[7072] = 35,
		[7073] = 36,
		[7074] = 38,
		[155] = 24,
		[932] = 51,
		[933] = 53,
		[934] = 55,
		[935] = 58,
		[936] = 58,
		[937] = 59,
		[7082] = 83,
		[7083] = 83,
		[7084] = 84,
		[7085] = 85,
		[7086] = 35,
		[7087] = 36,
		[7088] = 38,
		[7089] = 40,
		[7090] = 54,
		[7091] = 55,
		[7092] = 56,
		[7093] = 57,
		[7094] = 83,
		[7095] = 83,
		[7096] = 84,
		[7097] = 85,
		[991] = 59,
		[992] = 60,
		[993] = 61,
		[1001] = 57,
		[1002] = 58,
		[1003] = 59,
		[1004] = 60,
		[5101] = 22,
		[5102] = 25,
		[5103] = 27,
		[5104] = 29,
		[5111] = 35,
		[5112] = 37,
		[5113] = 39,
		[5114] = 40,
		[5115] = 41,
		[5116] = 42,
		[5121] = 45,
		[5122] = 47,
		[5123] = 49,
		[5124] = 52,
		[5125] = 53,
		[5126] = 54,
		[1031] = 67,
		[1032] = 69,
		[1033] = 70,
		[1034] = 71,
		[1035] = 72,
		[1036] = 73,
		[1037] = 71,
		[1038] = 72,
		[1039] = 73,
		[1040] = 74,
		[1041] = 75,
		[2222] = 69,
		[5142] = 37,
		[5143] = 39,
		[5144] = 40,
		[5145] = 41,
		[5146] = 42,
		[2223] = 70,
		[11109] = 70,
		[5151] = 45,
		[5152] = 47,
		[176] = 13,
		[5154] = 52,
		[5155] = 53,
		[5156] = 54,
		[1061] = 67,
		[1062] = 69,
		[1063] = 70,
		[1064] = 71,
		[1065] = 72,
		[1066] = 73,
		[1067] = 71,
		[1068] = 72,
		[1069] = 73,
		[1070] = 74,
		[1071] = 75,
		[2227] = 90,
		[1091] = 75,
		[1092] = 75,
		[1093] = 78,
		[1094] = 75,
		[1095] = 82,
		[1096] = 75,
		[2231] = 69,
		[1101] = 62,
		[1102] = 63,
		[1103] = 64,
		[1104] = 64,
		[1105] = 65,
		[1106] = 66,
		[1107] = 66,
		[2233] = 70,
		[1131] = 81,
		[1132] = 81,
		[1133] = 82,
		[1134] = 83,
		[1135] = 83,
		[1136] = 84,
		[1137] = 85,
		[1151] = 52,
		[1152] = 53,
		[1153] = 54,
		[1154] = 54,
		[1155] = 55,
		[1156] = 56,
		[1157] = 56,
		[2221] = 69,
		[1171] = 62,
		[1172] = 63,
		[1173] = 64,
		[1174] = 64,
		[2153] = 39,
		[1176] = 66,
		[1177] = 66,
		[1191] = 70,
		[1192] = 70,
		[11110] = 70,
		[2154] = 44,
		[11505] = 100,
		[11506] = 100,
		[11507] = 100,
		[11508] = 100,
		[11509] = 100,
		[11510] = 100,
		[2225] = 72,
		[1301] = 57,
		[1302] = 59,
		[1303] = 58,
		[1304] = 75,
		[1305] = 61,
		[1306] = 75,
		[1307] = 80,
		[1308] = 40,
		[1309] = 65,
		[1310] = 95,
		[7045] = 82,
		[7046] = 83,
		[2226] = 60,
		[7047] = 83,
		[7048] = 84,
		[1331] = 57,
		[1332] = 59,
		[1333] = 58,
		[1334] = 75,
		[1335] = 61,
		[5002] = 75,
		[5003] = 1,
		[7052] = 33,
		[11111] = 70,
		[7053] = 35,
		[7055] = 38,
		[1401] = 66,
		[1402] = 73,
		[1403] = 77,
		[7061] = 55,
		[7003] = 54,
		[7063] = 57,
		[5162] = 43,
		[7069] = 84,
		[5163] = 55,
		[931] = 49,
		[7076] = 54,
		[2232] = 69,
		[1501] = 69,
		[1502] = 72,
		[1503] = 76,
		[7078] = 55,
		[7079] = 56,
		[7080] = 57,
		[7081] = 82,
		[7075] = 40,
		[11100] = 50,
		[7077] = 54,
		[7009] = 53,
		[1601] = 68,
		[1602] = 70,
		[1603] = 75,
		[11101] = 50,
		[11102] = 50,
		[11113] = 90,
		[11103] = 50,
		[11104] = 50,
		[7049] = 85,
		[11105] = 50,
		[11106] = 70,
		[655] = 44,
		[1901] = 72,
		[1902] = 77,
		[1903] = 82,
		[1904] = 40,
		[1905] = 65,
		[1906] = 95,
		[11112] = 90,
		[2453] = 88,
		[11114] = 90,
		[2001] = 43,
		[2002] = 45,
		[2003] = 48,
		[2004] = 50,
		[2005] = 52,
		[11115] = 90,
		[2031] = 50,
		[2032] = 52,
		[2033] = 54,
		[2034] = 56,
		[2035] = 58,
		[2036] = 58,
}

function input_number(sentence)
	say(sentence)
	local n = nil

	while n == nil do
		n = tonumber (input())

		if n != nil then
			break
		end
		say("Something.")
	end
	return n
end

rep_q_level = {"Normal", "Master", "Grandmaster", "Perfect Master"}

ts_herbtime = {
	{24,20,16,12},
	{12,10,8,6},
	{6,6,6,6},
}

function herb_q_inf()
	return
	{	--			| Level 30-40 List | Level 40-50 List   | Level 50-60 List       | Level 60-70 List       | Level 70-80 List       | Level 80-90 List       | Level 90-99 List       |
		["vnum"] = {534,591,636,702,704,732,776,906,902,1001,1031,1101,1103,1301,2034,1156,1157,2064,2203,2204,2203,2204,2303,2304,2305,1131,1136,2314,2315,2401,2412,2403,2404,2411,2413},
		["Normal"] = {3,2,10,15,10,15,15,10,20,30,10,15,10,10,10,15,10,20,20,20,30,30,20,15,10,15,20,40,25,20,20,15,10,20,10},
		["Master"] = {5,3,15,20,15,25,20,15,30,50,15,25,15,15,15,25,20,30,30,30,50,50,30,20,15,25,30,60,40,35,40,30,20,40,20},
		["Grandmaster"] = {8,5,20,30,20,35,30,20,40,70,20,35,20,20,20,40,30,40,40,40,70,70,40,35,30,35,40,80,60,50,60,50,30,60,30},
		["Perfect_Master"] = {12,8,30,45,30,50,45,30,60,100,30,50,30,35,40,60,50,60,60,60,100,100,60,50,45,50,55,125,90,75,80,75,50,80,45},
	}
end

function herb_q_init_v(num)
	local info = herb_q_inf()
	local vnum = info.vnum[num]
	return vnum
end

function herb_q_init_a(qlv,num)
	local info = herb_q_inf()
	local qlv = pc.getqf("herblevel")
	local amount

	if qlv == 1 then
		amount = info.Normal[num]
	elseif qlv == 2 then
		amount = info.Master[num]
	elseif qlv == 3 then
		amount = info.Grandmaster[num]
	elseif qlv == 4 then
		amount = info.Perfect_Master[num]
	end

	return amount
end

----------------------------------------------
-- File: Metin2 Quest Extensions
----------------------------------------------

----------------------------------------------
-- Autor: Paylasici
----------------------------------------------

function q.get_input()
	cmdchat("QuestDeleteScrollStart")
	local input = input(cmdchat("QuestSendInput"))
	cmdchat("QuestDeleteScrollStop")
	return input
end

----------------------------------------------
-- Autor: Jami 
----------------------------------------------

function isdtamap(mapindex)
	if mapindex == 209 or mapindex == 210 or mapindex == 211 then
		return true
	else
		return false
	end
end

function get_next_char_num()
	local keystates = bitflags(DTA_keystates[pc.get_empire()], 7)

	if DTA_keystates[pc.get_empire()] == 127 then
		return 0
	end

	while true do
		local n = number(1, 7)
		if keystates[n] == 0 then
			keystates[n] = 1
			DTA_keystates[pc.get_empire()] = bitfield(keystates)
			return n + 1
		end
	end
end

----------------------------------------------
-- Autor: Mijago
----------------------------------------------

function duration(ipe) 
    local ipe, dat = ipe or 0,''
	local s, m, h, d, mo, y = 
					  tonumber(os.date('%S',ipe)),
					  tonumber(os.date('%M',ipe)),
					  tonumber(os.date('%H',ipe)),
					  tonumber(os.date('%d',ipe))-1,
					  tonumber(os.date('%m',ipe))-1,
					  tonumber(os.date('%Y',ipe))-1970

	for x, c in {{s, "Sec."}, {m, "Min."}, {h, "Hrs."}, {d, "Days", "Day"}, {mo, "Months", "Month"}, {y,"Years", "Year"}} do
		if (c[1] or 0) > 0 then
			if x > 1 then
				dat = ' '..dat
			end

            if c[1] > 1 then
                dat = c[1]..' '..c[2]..dat
            else 
                dat = c[1]..' '..(c[3] or c[2])..dat
            end
		end
	end	
    return dat
end

function is_number(var)
    return (type(var) == "number")
end

function local_pc_warp(name, x, y, mid)
    local target = find_pc_by_name(name)
    local t = pc.select(target)

    if mid == nil then
        mid = pc.get_map_index()
    end
    pc.warp_local(mid, x*100, y*100)
    pc.select(t)
end

function is_table(var)
    return (type(var) == "table")
end

function numtomoney(num)
    local num,out,x = tostring(num),'',0

    while string.len(num)-3 > 0 do
        out = string.gsub(num,'.-(%d%d%d)$','.%1')..out
        num = string.sub(num,0,string.len(num)-3)
    end
    return num..out
end

function split(str, delim, maxNb)
    if str == nil then
		return str
	end

    if string.find(str, delim) == nil then
		return { str }
	end

    if maxNb == nil or maxNb < 1 then
		maxNb = 0
	end

    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos

    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos

        if nb == maxNb then
			break
		end
    end

    if nb ~= maxNb then result[nb + 1] = string.sub(str, lastPos) end
		return
	result
end

function say2(str, dx) 
    local maxl, actl, pat = dx or 50, 0, '(.-)(%[.-%])()' 
    local result,nb,lastPos,outp = {}, 0, 0, '' 
    local function bere(stx)
        for le in string.gfind(stx,'((%S+)%s*)') do
            if actl + string.len(le) > maxl then
                outp = outp..'[ENTER]'
                actl = 0  
            end

            outp = outp..le  
            actl = actl + string.len(le)
        end 
    end

    for part, dos,pos in string.gfind(str, pat) do  
        if part ~= '' then  
            bere(part) 
        end

        outp = outp..dos  
        lastPos = pos  
    end
    bere(string.sub(str, lastPos)) 
    say(outp) 
end

----------------------------------------------
-- Autor: Unknown
----------------------------------------------
function say_blue(name)
	say(color256(0, 0, 255)..name..color256(0, 0, 255))
end

function say_red(name)
	say(color256(255, 0, 0)..name..color256(255, 0, 0))
end

function say_green(name)
	say(color256(0, 238, 0)..name..color256(0, 238, 0))
end

function say_gold(name)
	say(color256(255, 215, 0)..name..color256(255, 215, 0))
end

function say_black(name)
	say(color256(0, 0, 0)..name..color256(0, 0, 0))
end

function say_white(name)
	say(color256(255, 255, 255)..name..color256(255, 255, 255))
end

function say_yellow(name)
	say(color256(255, 255, 0)..name..color256(255, 255, 0))
end

function string:split(delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(self, delimiter, from)

	while delim_from do
		table.insert(result, string.sub(self, from , delim_from-1))
		from = delim_to + 1
		delim_from, delim_to = string.find(self, delimiter, from)
	end
	table.insert(result, string.sub(self, from))
	return result
end