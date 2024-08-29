-- -----------------------------------------------------------------
-- SUBQUEST
--LV 30
-- Aranyo¡¯s Husband
--------------------------------------------------------------------
quest subquest_18 begin
        state start begin
                when login or levelup with pc.level >= 10 and pc.level <=12  begin
                        set_state(information)
                end
        end

        state information begin
                when letter begin
                        local v=find_npc_by_vnum(20002)
                        if 0!=v then
                        target.vid("__TARGET__", v, "Where does he hide?")
                        end
                end
                when __TARGET__.target.click or
                        20002.chat."Where does he hide?"  begin
                        target.delete("__TARGET__")
                        say_title("Aranyo")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("My husband is really the biggest pain for me. He calls")
                        say("himself a scholar! While we have problems getting something")
                        say("to eat everyday, he only wants to reads his books.")
                        say("")
                        say("Have you seen him? ")
                        say("")
                        say("Why did I marry such a bookworm.")
                        say("")

                        local s=select("I help you.","I have no time for this.")

                        if 2==s then
                                say("Are you sure you want to refuse her request?")
                                say("")
                                local a= select("Yes","No")
                                if 2==a then
                                        say_title("Aranyo")
                                        say("")
                                        say("Well..")
                                        say("Maybe you look for him later on.")
                                        say("")
                                        return
                                end
                                        say_title("Aranyo")
                                        say("")
                                        say("Maybe I will find him somehow.")
                                        say("")
                                set_state(__GIVEUP__)
                                return
                        end
                                say_title("Aranyo")
                                say("")
                                ----"123456789012345678901234567890123456789012345678901234567890"|
                                say("I will be very grateful. When you find a poor writer, let")
                                say("me know. He is surely the only one anyway in the village.")
                                say("")
                                say("Maybe he is thinking about one poem or another and stays")
                                say("alone because of this.")
                                say("")
                                say("When he hears that I look for him he might flee.")
                                say("")
                        set_state(find_mrsoon)

                end
        end
        state find_mrsoon begin
                when letter begin
                        send_letter("Search for Mr.Soon.")

                        local v=find_npc_by_vnum(20023)
                        if 0!=v then
                                target.vid("__TARGET2_", v, "Search for Mr.Soon.")
                        end

                end
                when button or info begin
                        say_title("Search for Mr. Soon")
                        say("")
                        say("Search for a man reading poems and wearing rags.")
                        say("")
                end
                when 20002.chat."Where is my husband?"  begin
                        say_title("Aranyo")
                        say("")
                        say("Where could he hide? He became good in hiding.")
                        say("")
                        say("It is rather hard to find him. ")
                        say("")
                        say("I wonder if I really should get him to wear a bell")
                        say("hanging around his neck.")
                        say("")
                end
                when  __TARGET2__target.click or
                        20023.chat."Find Mr.Soon!"  begin
                        target.delete("__TARGET2_")
                        say_title("Information:")
                        say("")
                        say("I heard a wonderful poem. I followed this and found a man")
                        say("in rags. This man could be Aranyo's husband!")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("I wanted to turn around and tell her about it, when someone")
                        say("grabbed my shoulder...")
                        say("")
                        wait()
                        say_title("Mr.Soon:")
                        say("")
                        say("You are not from here. Did my wife send you?")
                        say("")
                        say_title(pc.get_name()..":")
                        say("")
                        say("Oh no! He knows who I am! Shall I tell him the truth?")
                        say("")
                        local s=select("No no, of course not","Well...")

                        if 1==s then
                                say_title("Mr.Soon:")
                                say("")
                                ----"123456789012345678901234567890123456789012345678901234567890"|
                                say("Ahem, nice to meet you. Wonderful weather we are having.")
                                say("")
                                say("Have you read any good book lately?")
                                say("")
                                say("I'm currently reading a book written by Oja; you should")
                                say("really read it.")
                                say("")
                                set_state(report_true)
                        elseif 2==s then
                                say_title("Mr.Soon:")
                                say("")
                                ----"123456789012345678901234567890123456789012345678901234567890"|
                                say("I guess I am right. My wife now teases me that hard, I")
                                say("cannot read peacefully at home.")
                                say("")
                                say("She does not understand my soul at all.")
                                say("")
                                say("You may have found me here, but I could go away.")
                                say("")
                                say("How about not telling her anything? As reward, I will give")
                                say("you good hunting advice!")
                                say("")
                                set_state(report_false)
                        end
                end
        end
        state report_false begin
                when letter begin
                        send_letter("Return to Aranyo")
                        local v=find_npc_by_vnum(20002)
                        if v!=0 then
                                target.npc("__TARGET__", v, "Return to Aranyo")
                        end
                end
                when button or info begin
                        say_title("Return to Aranyo")
                        say("")
                        say("Return to Aranyo and tell her that you could not find Mr.Soon.")
                        say("")
                end

                when __TARGET__.target.click or
                        20002.chat."Mr.Soons Secret" begin
                        target.delete("__TARGET__")
                        say_title("Aranyo")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("You could not find him? I even prepared traps!!!")
                        say("")
                        say("Where the heck does he hide? ")
                        say("")
                        say("And I am so busy... What a sad fate I have.")
                        say("")
                        set_state(come_back)
                end
        end
        state come_back begin
                when letter begin
                        send_letter("Return to Mr.Soon")
                        local v=find_npc_by_vnum(20023)
                        if v!=0 then
                                target.npc("__TARGET__", v, "Return to Mr.Soon")
                        end
                end
                when button or info begin
                        say_title("Return to Mr.Soon")
                        say("")
                        say("Return to Mr.Soon and tell him that you were successful.")
                        say("")
                end
                when __TARGET__.target.click or
                        20023.chat."Here am I." begin
                           target.delete("__TARGET__")
                        say_title("Mr.Soon:")
                        say("")
                        say("Take this, Adventurer.")
                        say("Everything went well, you saved my life!")
                        say("As promised, here is a reward.")
                        say("")
                        say_title("Reward")
                        say("")
                        say_reward("You received 7.000 Experience")
                        pc.give_exp2(7000)
                        say_reward("You received 5.000 Yang")
                        pc.change_money(10000)
                        say("")

                        clear_letter()
                        set_state(__COMPLETE__)
                end
        end

        state report_true begin
                when letter begin
                        send_letter("Return to Aranyo")
                        local v=find_npc_by_vnum(20002)
                        if v!=0 then
                                target.npc("__TARGET__", v, "Return to Aranyo")
                        end
                end

                when button or info begin
                        say_title("Return to Aranyo")
                        say("")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("Return to Aranyo and tell her where you found Mr.Soon.")
                        say("")
                end
                when 20023.chat."Hiding is hard" begin
                        say_title("Mr.Soon:")
                        say("")
                        say("Thank you. You did not blow my cover.")
                        say("")
                        say("It is so hard to hide from my wife. I just want to study")
                        say("here peacefully.")
                        say("")
                end
                when __TARGET__.target.click or
                        20002.chat."Mr.Soon hiding spot" begin
                        target.delete("__TARGET__")
                        say_title("Aranyo:")
                        say("")
                        say("You found him?")
                        ----"123456789012345678901234567890123456789012345678901234567890"|
                        say("")
                        say("Thank you very much! If he finds out he might flee...")
                        say("I will go there immediately.. this time... hehehe.")
                        say("")
                        say("Oh! Here is a sign of my appreciation.")
                        say("")
                        say_title("Reward")
                        say("")
                        say_reward("You receive 10.000 Experience")
                        pc.give_exp2(10000)
                        say_reward("You receive 9.000 Yang")
                        pc.change_money(9000)
			say("")
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
