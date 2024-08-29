----------------------------------------------------
-- SUB QUEST
-- LV  40
-- Capture the Boss of the "Blackwind Clan"
----------------------------------------------------

quest subquest_34 begin
        state start begin
                when login or levelup or enter with pc.get_level() >=40  and pc.get_level() <= 42 begin
                        set_state( information )
                end
        end

        state information begin
                when letter begin

                        local v = find_npc_by_vnum(20355)

                        if v != 0 then
                                target.vid("__TARGET__", v, "Go to the Captain")
                        end
                end


                when __TARGET__.target.click or
                        20355.chat."Kill the Generals of the Black Wind Clan" with pc.level >= 40  begin
                        target.delete("__TARGET__")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say_title("Captain :")
                        say("")
                        say("Although you defeated the Black Wind Clan,")
                        say("they don't give up.")
                        say("Instead of staying calm, they are like a ")
                        say("wild horde.")
                        say("If we want to defeat them, we have to kill the")
                        say("Generals of the Black Wind.")
                        say("")
                        wait()
                        say_title("Captain:")
                        say("")
                        say("As soon as the Generals are defeated, the others")
                        say("will be as well. It will be hard work but we need")
                        say("a victory over the Black Wind Generals:")
                        say("Jak-To, To-Su, Gu-Ryung.")
                        say("When we have defated them, we don't have to")
                        say("worry about the Black Wind Clan.")
                        say("Good luck, I pray for your victory.")
                        say("")
                        local s=select("Ok.","Cancel.")
                        if 2==s then
                                say("Do you want to cancel the Quest?")
                                local a=select("Yes","No")
                                if  2==a then
                                        say_title("Captain:")
                                        say("")
                                        say("Well, when you are ready, visit me")
                                        say("again.")
                                        say("There are few people like you.")
                                        return
                                end
                                say_title("Captain:")
                                say("")
                                say("You can't do it...")
                                say("How shall we defeat the")
                                say("Black Wind Clan...")
                                set_state(__GIVEUP__)
                                return
                        end
                        say_title("Captain:")
                        say("")
                        say("I knew you would try it.")
                        say("As soon as the generals are killed,")
                        say("the others are no problem.")
                        say("Good luck.")
                        say("")
                        set_state(bye_blackwind)
                end
        end
        state bye_blackwind begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Kill the Generals of the Black Wind")
                        q.set_title("Kill the Generals of the Black Wind")
                        q.start()
                end

                when info or button begin
                        say_title("Kill the Generals of the Black Wind")
                        say("")
                        say("Kill the Generals of the Black Wind, they")
                        say("are bad news.")
                        say("Their names: Jak-To, To-Su, Gu-Ryung.")
                        say("")

                end
                when 11004.chat."Kill the Generals of the Black Wind" with pc.level >=32 begin
                        say("Generals are killed!")
                        say("")
                        local s=select("Again","Cancel")
                        if 2==s then
                                say("You really want to cancel the Quest?")
                                local a=select("Yes","No")
                                if  2==a then
                                        say_title("Captain:")
                                        say("")
                                        say("It isn't easy to win, especially")
                                        say("against the generals.")
                                        say("Try it again")
                                        return
                                end
                                say_title("Captain:")
                                say("")
                                say("As I said, the Black Winds ")
                                say("are strong.")
                                say("Good Bye.")
                                set_state(__GIVEUP__)
                                return
                        end
                        say_title("Captain:")
                        say("")
                        say("You are really brave.")
                        say("I think you can defeat the Black Wind Clan.")
                        say("")
                end


                when 404.kill begin
                        pc.setqf("kill_m1",1)

                        if        pc.getqf("kill_m1")==1        and        pc.getqf("kill_m2")==1 and        pc.getqf("kill_m3")==1        then
                                set_state(hunt_reward)
                        end
                        return
                end
                when 405.kill begin
                                pc.setqf("kill_m2",1)

                                if        pc.getqf("kill_m1")==1        and        pc.getqf("kill_m2")==1 and        pc.getqf("kill_m3")==1        then
                                        set_state(hunt_reward)
                                end
                                return

                end

                when 406.kill begin
                        pc.setqf("kill_m3",1)

                        if        pc.getqf("kill_m1")==1        and        pc.getqf("kill_m2")==1 and        pc.getqf("kill_m3")==1        then
                                set_state(hunt_reward)
                        end
                        return

                end


        end

        state hunt_reward begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Kill the Generals of the Black Wind")
                        q.set_title("Kill the Generals of the Black Wind")
                        q.start()

                        local v = find_npc_by_vnum(20355)

                        if v != 0 then
                                target.vid("__TARGET__", v, "Inform the Captain")
                        end
                end

                when info or button begin
                        say_title("Kill the Generals of the Black Wind")
                        say("")
                        say("Return to the Captain and inform him that you")
                        say("killed the Generals of the Black Wind.")
                        say("")
                end

                when __TARGET__.target.click or
                        20355.chat."Kill the Generals of the Black Wind" begin
                        target.delete("__TARGET__")
                        say_title("Captain:")
                        say("")
                        say("You defeated the generals.")
                        say("And the others are easy to defeat without")
                        say("them, we will do the rest.")
                        say("We had a lot of headaches because of ")
                        say("the Black Wind Clan, but thanks to you")
                        say("we will make it.")
                        say("Here is a little reward.")
                        say("I hope to see you again!")
                        say("")
                        say_reward("You received a Language Ring")
                        pc.give_item2(71007)

                        say_reward("You received 1.500.000 Experience Points.")
                        pc.give_exp2(1500000)

                        set_state(__COMPLETE__)
                        clear_letter()
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
