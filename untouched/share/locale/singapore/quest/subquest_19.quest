--------------------------------------------------
-- SUB QUEST
-- LV 6
-- Looking for a dusting brush
----------------------------------------------------

quest subquest_19  begin
        state start begin
                when login or levelup with pc.level >= 12  and pc.level <=17 begin
                        set_state(information)
                end
        end

        state information begin
                when letter begin
                        local v=find_npc_by_vnum(9006)
                        if 0==v then
                        else
                                target.vid("__TARGET__", v, "Old Lady")
                        end
                end

                when __TARGET__.target.click or 9006.chat."Search a Dusting Brush" begin
                        target.delete("__TARGET__")
                        say_title("Old Lady")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("Cough! Cough! Oh dear, this cough drains me and I have")
                        say("nothing to clean my house and so all dust stays inside.")
                        say("Oh, why do I haven't got a Dusting Brush?")
                        say("")
                        say("My son took it to work for some weapons.")
                        say("")
                        say("My own flesh and blood kills me.")
                        say("")
                        local b=select("I look for one.", "Sorry, I have no time.")
                        if 2==b then
                                say_title("Old Lady")
                                say("")
                                say("*Cough* Cough* Everything is dusty.")
                                say("I need a Dusting Brush, do you want to help me?")
                        else
                                say_title("Old Lady")
                                say("")
                                ----"123456789012345678901234567890123456789012345678901234567890"|
                                say("It was a while ago, but I think that my husband who now")
                                say("rests in peace, used to make them from Lupine Fur.")
                                say("Cough! Cough!")
                                say("")
                                say("Could you maybe get a Lupine Fur for an Old Lady? You can")
                                say("get it from a Hungry Grey Wolf.")
                                say("")
                                say("You would help me a lot.")
                                say("")
                        end
                        local r=select("Accept", "Reject")
                        if 2==r then
                                say("You really want to cancel?")
                                local a=select("Yes" ,"No")
                                if 2==a then
                                        say_title("Old Lady")
                                        say("")
                                        ----"123456789012345678901234567890123456789012345678901234567890"|
                                        say("Oops,a shame. I thought you'd help me. Maybe you")
                                        say("reconsider this and come back again.")
                                        say("")
                                        return
                                end
                                say_pc_name()
                                        say("")
                                        say("What kind of reward could one expect")
                                        say("from such an old, poor woman?")
                                        say("")
                                set_state(__GIVEUP__)
                                return
                        end
                        say_pc_name()
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("It isn't that easy to get a Lupine Fur, but I will try!")
                        say("")
                        say("I want to become a great hero, you know.")
                        say("")
                        set_state(find)
                end
        end
        state find begin
                when letter begin
                        send_letter("Get Lupine Fur")
                end
                when info or button begin
                        say_title("Get Lupine Fur")
                        say("")
                        say("Get Lupine Fur so the Old Lady can clean her house.")
                        say("")
                        say("You can get one from the Hungry Grey Wolf.")
                        say("")
                end

                when 176.kill begin
                        local s = number(1, 100)
                        if s <= 5 and pc.count_item("30151")==0  then
                                pc.give_item2("30151", 1)
                                local v=find_npc_by_vnum(9006)
                                if 0==v then
                                else
                                        target.vid("__TARGET__",v,"Return to Old Lady")
                                end
                        end
                end

                when 9006.chat."Deliver Lupine Fur" with pc.count_item("30151") == 0 begin
                        say_title("Old Lady:")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("That is a ... Oh, no. It is not the right Lupine Fur.")
                        say("Go back to the wilderness, maybe you find the right one.")
                        say("")
                        say_item_vnum(30151)
                        say("I need a real Dusting Brush. With this I can't do anything.")
                        say("")

                        local s=select("Try it again.","I do not want anymore.")
                        if 2==s then
                                say("Do you really want to cancel?")
                                local a=select("Yes","No")
                                if  2==a then
                                        say_title("Old Lady:")
                                        say("")
                                        say("Come again later on.")
                                        say("")
                                        return
                                end
                                say_title("Old Lady:")
                                say("")
                                say("I know it is hard, but please try again.")
                                say("")
                                set_state(__GIVEUP__)
                                return
                        end

                        say_title("Old Lady:")
                        say("")
                        say("Thank you I'm sure you can do it.")
                        say("")

                 end


                when __TARGET__.target.click or
                        9006.chat."Deliver LupineFur" with pc.countitem("30151")>=1 begin
                        target.delete("__TARGET__")
                        say_title("Old Lady")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("You are the Adventurer? My cough sounds bad. *cough* *cough*")
                        say("As you hear I still have this bad cough. The house is still")
                        say("full of dust. Oh, you brought me a Lupine Fur?")
                        say("")
                        say("Yes! That is the right one. Thank you very much.")
                        say("")
                        say("Wait here one second please.")
			say("")
                        wait()
                        say_title("Old Lady:")
                        say("")
                        say("One, Two, one, two. Finally I can clean my house.")
                        say("I found this, maybe you can use it.")
                        say("")
                        say("Maybe a lot, maybe nothing, I really do not know how")
                        say("much it is worth. Thank you, take care of yourself.")
                        say("")
                        pc.removeitem("30151", 1)
                        setstate(reward)
                end
        end
        state reward begin
                when letter begin
                        send_letter("A dusty something")
                end
                when info or button begin
                        say_title("A dusty something")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("As a reward you got an item that seems to be only garbage.")
                        say("")
                        say("You nosily undust it.")
                        say("")

                        local s=number(1, 3)
                        if 1>=s then -- 33.33% (1/3)
					----"123456789012345678901234567890123456789012345678901234567890"|
                                        say_reward("It is an old valuable Armour. The work of a good Blacksmith.")
					say_reward("")
					say_reward("That is luck!")

                                local r=number(1, 16)
                                if r==1 then
                                        pc.give_item2("11206", 1)
                                elseif r==2 then
                                        pc.give_item2("11216", 1)
                                elseif r==3 then
                                        pc.give_item2("11406", 1)
                                elseif r==4 then
                                        pc.give_item2("11416", 1)
                                elseif r==5 then
                                        pc.give_item2("11606", 1)
                                elseif r==6 then
                                        pc.give_item2("11616", 1)
                                elseif r==7 then
                                        pc.give_item2("11806", 1)
                                elseif r==8 then
                                        pc.give_item2("11816", 1)
                                elseif r==9 then
                                        pc.give_item2("11205", 1)
                                elseif r==10 then
                                        pc.give_item2("11215", 1)
                                elseif r==11 then
                                        pc.give_item2("11405", 1)
                                elseif r==12 then
                                        pc.give_item2("11415", 1)
                                elseif r==13 then
                                        pc.give_item2("11605", 1)
                                elseif r==14 then
                                        pc.give_item2("11615", 1)
                                elseif r==15 then
                                        pc.give_item2("11805", 1)
                                elseif r==16 then
                                        pc.give_item2("11815", 1)
                                end
                        elseif 2>=s then -- 33.33% (1/3)

                                        ----"123456789012345678901234567890123456789012345678901234567890"|
                                        say_reward("It is old but still useful.. not a bad armour.")


                                local r=number(1, 16)
                                if r==1 then
                                        pc.give_item2("11204", 1)
                                elseif r==2 then
                                        pc.give_item2("11214", 1)
                                elseif r==3 then
                                        pc.give_item2("11404", 1)
                                elseif r==4 then
                                        pc.give_item2("11414", 1)
                                elseif r==5 then
                                        pc.give_item2("11604", 1)
                                elseif r==6 then
                                        pc.give_item2("11614", 1)
                                elseif r==7 then
                                        pc.give_item2("11804", 1)
                                elseif r==8 then
                                        pc.give_item2("11814", 1)
                                elseif r==9 then
                                        pc.give_item2("11203", 1)
                                elseif r==10 then
                                        pc.give_item2("11213", 1)
                                elseif r==11 then
                                        pc.give_item2("11403", 1)
                                elseif r==12 then
                                        pc.give_item2("11413", 1)
                                elseif r==13 then
                                        pc.give_item2("11603", 1)
                                elseif r==14 then
                                        pc.give_item2("11613", 1)
                                elseif r==15 then
                                        pc.give_item2("11803", 1)
                                elseif r==16 then
                                        pc.give_item2("11813", 1)
                                end
                        elseif 3>=s then -- 33.33% (1/3)
                                        say_reward("Bah forget it,this Armour is nearly useless...")

                                local r=number(1, 8)
                                if r==1 then
                                        pc.give_item2("11200", 1)
                                elseif r==2 then
                                        pc.give_item2("11210", 1)
                                elseif r==3 then
                                        pc.give_item2("11400", 1)
                                elseif r==4 then
                                        pc.give_item2("11410", 1)
                                elseif r==5 then
                                        pc.give_item2("11600", 1)
                                elseif r==6 then
                                        pc.give_item2("11610", 1)
                                elseif r==7 then
                                        pc.give_item2("11800", 1)
                                elseif r==8 then
                                        pc.give_item2("11810", 1)
                                end
                        end
                        say("")
                        say_reward("You received 10.000 Experience points.")
                        say("")
                        pc.give_exp2(10000)
                        clear_letter()
                        set_state(__COMPLETE__)
                end
        end

        state __GIVEUP__ begin
        end

        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end
