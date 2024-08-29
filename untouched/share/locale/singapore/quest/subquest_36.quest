--------------------------------------------------
-- SUB QUEST
-- LV 47
-- Rescue the stables in trouble
----------------------------------------------------

quest subquest_36 begin
        state start begin
                when login or levelup with pc.level >= 47 and pc.level <= 49 begin
                        set_state(information)
                end
        end

        state information begin
                when letter begin
                        local v=find_npc_by_vnum(20005)
                        if 0==v then
                        else
                                target.vid("__TARGET__", v, "Yonah")
                        end
                end


        when __TARGET__.target.click or
                    20005.chat."The Stallions are in trouble" begin
                        target.delete("__TARGET__")
                        say_title("Yonah:")
                        say("")
                        say("Hey, I have a question!")
                        say("I know someone else is the Keeper of")
                        say("the Stallions,")
                        say("but we have lots of trouble.")
                        say("The Horses were drained because")
                        say("of the war.")
                        say("Grown up Horses also have a limit")
                        say("and yeah...")
                        say("")
                        wait()
                        say_title("Yonah:")
                        say("")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say("There are many Horses but not enough food.")
                        say("Many horses die.")
                        say("Can you get them some food so that Horses can")
                        say("survive? Only you can fulfil this task.")
                        say("Collect 10 pieces of food and bring it there.")
                        say("He will understand when you say")
                        say("you come from me.")
                        say("")
                        local s=select("Ok","Cancel")
                        if 2==s then
                                say("You want to cancel the Quest?")
                                local a=select("Yes","No")
                                if 2==a then
                                        say_title("Yonah:")
                                        say("")
                                        say("Nowadays more and more people want")
                                        say("Horses.")
                                        say("But there aren't enough Horses.")
                                        say("There isn't enough food.")
                                        say("The Horses starve.")
                                        say("When you have changed your mind come back.")
                                        say("")
                                        return
                                end
                                say_title("Yonah:")
                                say("")
                                say("Argh, the Horses stay underfed.")
                                say("Have to live with it.")
                                say("")
                                set_state(__GIVEUP__)
                                return
                        end
                        say_title("Yonah:")
                        say("")
                        say("I know you are busy ")
                        say("but can't you favour me?")
                        say("Horses are really important now.")
                        say("We need the basis food hay.")
                        say("")
                        set_state(for_horse)
                end
        end


state for_horse begin
        when letter begin
            send_letter("The Stallions are in trouble")
                if         pc.count_item(50054)>=10 then
                        local v=find_npc_by_vnum(20349)
                        if 0==v then
                        else
                                target.vid("__TARGET__", v, "Go to the Stable Boy")
                        end
                end

        end
        when button or info begin
                if         pc.count_item(50054)>=10 then
                            say_title("I have the Hay")
                        say("")
                        say("Let's take those 10 Pieces")
                        say("of Hay to the Stable Boy. He has problems")
                        say("with the feeding of the Horses.")
                        say("")
                        return
                end

                say_title("get the Basic food Hay")
                say("")
                say("The Stable Boy is a friend of Yonah.")
                say("He asked you to get 10 pieces of hay")
                say("for the Horses.")
                say("Bring the Hay to the Lad.")
                say("You get it on the hunt.")
                say("")
        end



        when 20349.chat."Help the Stable Boy" with pc.count_item(50054) ==0 or
        pc.count_item(50054) < 10 begin
                say_title("Stable Boy:")
                   say("")
                say("You are here because Yonah")
                say("sent you?")
                say("I heard many stories about you.")
                say("Ah, all of our Horses starve,")
                say("They have to survive, please")
                say("help me.")
                say("")
            local s=select("Move on","Cancel")
            if 1==s then
                        say_pc_name()
                        say("")
                        say("Promises of men are important...")
                        say("But hey, maybe I can")
                        say("ride a Horse..")
                        say("I have to look for him")
                        say("")
                        return

            else
                        say_pc_name()
                        say("")
                        say("I'm sorry I look for him.")
                        say("My Skill Level isn't high enough.")
                        say("")
                        wait()
                        say_title("Stable Boy:")
                        say("")
                        say("I wait and I hope that you can make")
                        say("it.")
                        say("Okay, it is really not nice to give you my")
                        say("work.")
                        say("But - could you try again?")
                        say("")
                        say("I know a person in the other kingdom,")
                        say("he is very strong.")
                        say("When you help me, I ask him to ")
                        say("help you.")

                        local s=select("Again","Cancel")
                        if 1==s then
                                say_pc_name()
                                say("")
                                say("I cannot help you.")
                                say("I don't have the strength.")
                                say("")
                                return

                        elseif 2==s then
                                say_pc_name()
                                say("")
                                say("I don't have enough energy.")
                                say("I would like to help you but ")
                                say("I can't")
                                say("I'm not strong enough.")
                                say("")
                                set_state(__GIVEUP__)
                        end
            end
        end



        when __TARGET__.target.click or
                20349.chat."Bring the Horsefeed Hay" with pc.count_item(50054)>=10 begin
                target.delete("__TARGET__")
                say_title("Stable Boy:")
                say("")
                say("You come from Yonah?")
                say("You have the Hay?")
                say("Oh, thanks.")
                say("We had troubles with the horse food.")
                say("So we told Yonah and he")
                say("said he could solve the problem.")
                say("I didn't know he could do it")
                say("that well.")
                say("Thanks a lot for your help.")
                say("")
                say_reward("You receive 1.800.000 Experience Points.")
                pc.give_exp2(1800000)

                pc.remove_item(50054,10)
                set_state(OLD_MAN_DONE)
        end
  end

  state OLD_MAN_DONE begin
        when letter begin
                        send_letter("Return to Yonah!")
                        local v=find_npc_by_vnum(20005)
                        if 0==v then
                        else
                                target.vid("__TARGET__", v, "Yonah")
                        end

                end
        when button or info begin
                say_title("Return to Yonah")
                say("")
                say("Return to Yonah and tell him")
                say("that you brought 10 Pieces of Hay to")
                say("the Stable Boy.")
                say("")
        end
        when __TARGET__.target.click or
                20005.chat."Hay Delievery finished!" begin
                target.delete("__TARGET__")
                say_title("Yonah")
                say("")
                say("Hey, you are back!")
                say("It was surely a hard job.")
                say("Here is a little present.")
                say("")
            
		say_reward("You receive Horse Taming Manual.")
		pc.give_item2(50061) 
                set_state(__COMPLETE__)
                clear_letter()

        end
end
    state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
        state __GIVEUP__ begin
    end
end
