quest collect_quest_reset_v2 begin
	state start begin
		when login with pc.level >= 92 begin
			if tostring(get_quest_state("collect_quest_lv92")) == "557528158" or tostring(get_quest_state("collect_quest_lv92")) == "1918565466" or
				tostring(get_quest_state("collect_quest_lv94")) == "557528158" or tostring(get_quest_state("collect_quest_lv94")) == "1918565466" or 
				tostring(get_quest_state("collect_quest_lv96")) == "557528158" or tostring(get_quest_state("collect_quest_lv96")) == "1918565466" then
				set_state( check_reset_able )
			end
		end
	end

	state check_reset_able begin
		when 20091.chat."You want to change the reward?" begin
			---                                                   l
			say_title("Seon-Pyeong:")
			say("")
			say("Do you want to change the reward that you had?")
			say("Hmmmm....")
			say("")

			wait()

			say_title("Seon-Pyeong:")
			say("")
			say("Well.. I need the heavenly jade by the way.")
			say("I was going to look for you")
			say("Besides the gems you got for me, there is also")
			say("Heavenly Jade in Heaven's Lair")
			say("")
			say("Can you get me 5 of them?")
			say("")

			wait()

			say_title("Seon-Pyeong:")
			say("")
			say("If you get 5 heavenly jade, I will change one")
			say("of the rewards you had before.")
			say("")
			say("How about that?")
			say("")

			local s = select("Allright", "Let me think.")

			if s == 1 then
				say_title("Seon-Pyeong:")
				say("")
				say("I'll be waiting for you.")
				say("")

				set_state( find_jewel )
			else
				say_title("Seon-Pyeong:")
				say("")
				say("Sure, you need to think carefully")
				say("")
			end
		end
	end

	state find_jewel begin
		when letter begin
			send_letter("Seon-Pyeong's offer")
		end

		when button or info begin
			say("")
			say("Bring 5 Heavenly Jades to Seon-Pyeong")
			say("in Dragon Valley to change the reward.")
			say("")

			say_item_vnum( 30254 )

			say_reward("Currently "..pc.getqf("collect_count").."  Heavenly Jades collected.")
			say("")
		end

		when 2401.kill or 2402.kill or 2403.kill or 2404.kill begin
			if number(1, 100) <= 3 then
				pc.give_item2(30254, 1)
				send_letter("You got Heavenly Jade!")
			end
		end

		when 2411.kill or 2412.kill or 2413.kill or 2414.kill begin
			if number(1, 100) <= 5 then
				pc.give_item2(30254, 1)
				send_letter("You got Heavenly Jade!")
			end
		end

		when 20091.chat."Did you bring the heavenly jade?" with pc.count_item(30254) > 0 begin
			pc.remove_item( 30254 , 1 )

			say_title("Seon-Pyeong:")
			say("")
			say("Ah, here you are. Let me see...")

			setdelay(150)
			say("Hmmm...")
			resetdelay()

			if number(1, 100) <= 20 then
				say("This one is fake.")
				say("Please find another one for me.")
				say("")
				return
			end

			say("Yes... This is true Heavenly Jade!!")
			say("")

			wait()

			local count = pc.getqf( "collect_count" ) + 1

			if count < 5 then
				pc.setqf( "collect_count", count )

				say_title("Seon-Pyeong:")
				say("")
				say("Now you need to bring " .. 5-count .. " more.")
				say("Keep up the good work!")
				say("")
				return
			end
			
			say_title("Seon-Pyeong:")
			say("")
			say("As I promised, I will change your rewards")
			say("")

			local selTab = {}
			local pos = 1 

			if tostring(get_quest_state("collect_quest_lv92")) == "557528158"  or tostring(get_quest_state("collect_quest_lv92")) == "1918565466" and
				tostring(get_quest_state("collect_quest_lv94")) != "1918565466" and
				tostring(get_quest_state("collect_quest_lv94")) != "557528158" and
				tostring(get_quest_state("collect_quest_lv96")) != "1918565466" and
				tostring(get_quest_state("collect_quest_lv96")) != "557528158" then
				table.insert(selTab, pos, "92 sky gem reward")
				pos = pos + 1
			end

			if tostring(get_quest_state("collect_quest_lv92")) == "557528158"  or tostring(get_quest_state("collect_quest_lv92")) == "1918565466" and
				tostring(get_quest_state("collect_quest_lv94")) == "557528158"  or tostring(get_quest_state("collect_quest_lv94")) == "1918565466" and
				tostring(get_quest_state("collect_quest_lv96")) != "1918565466" and
				tostring(get_quest_state("collect_quest_lv96")) != "557528158" then
				table.insert(selTab, pos, "92 and 94 sky gem reward")
				pos = pos + 1
			end

			if tostring(get_quest_state("collect_quest_lv92")) == "557528158"  or tostring(get_quest_state("collect_quest_lv92")) == "1918565466" and
				tostring(get_quest_state("collect_quest_lv94")) == "557528158"  or tostring(get_quest_state("collect_quest_lv94")) == "1918565466" and
				tostring(get_quest_state("collect_quest_lv96")) == "557528158"  or tostring(get_quest_state("collect_quest_lv96")) == "1918565466" then
				table.insert(selTab, pos, "92, 94 and 96 sky gem reward")
				pos = pos + 1
			end

			local s = select_table( selTab )

			if selTab[s] == "92 sky gem reward" then
				affect.remove_collect(1, 1000)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 300)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 100)
				pc.setf("collect_quest_lv92","block_id",0)
				
				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 92 Quest reward.")
					say("")
					s = select("Health +1000","Defence +300","Attack +100")
					if 1== s then
						if pc.getf("collect_quest_lv94","block_id") == 1 or pc.getf("collect_quest_lv96","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 1000, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv92","block_id",1)
							break
						end
					elseif 2== s then
						if pc.getf("collect_quest_lv94","block_id") == 2 or pc.getf("collect_quest_lv96","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 300, 60*60*24*365*60) 
							pc.setf("collect_quest_lv92","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv94","block_id") == 3 or pc.getf("collect_quest_lv96","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,100,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv92","block_id",3)
							break
						end
				    end
				end
			elseif selTab[s] == "92 and 94 sky gem reward" then
				affect.remove_collect(1, 1000)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 300)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 100)
				pc.setf("collect_quest_lv92","block_id",0)
				affect.remove_collect(1, 1500)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 500)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 200)
				pc.setf("collect_quest_lv94","block_id",0)
				
				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 92 Quest reward.")
					say("")
					s = select("Health +1000","Defence +300","Attack +100")
					if 1== s then
						if pc.getf("collect_quest_lv94","block_id") == 1 or pc.getf("collect_quest_lv96","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 1000, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv92","block_id",1)
							break
						end
					elseif 2== s then
						if pc.getf("collect_quest_lv94","block_id") == 2 or pc.getf("collect_quest_lv96","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 300, 60*60*24*365*60) 
							pc.setf("collect_quest_lv92","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv94","block_id") == 3 or pc.getf("collect_quest_lv96","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,100,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv92","block_id",3)
							break
						end
				    end
				end
				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 94 Quest reward.")
					say("")
					s2 = select("Health +1500","Defence +500","Attack +200")
					if 1== s2 then
						if pc.getf("collect_quest_lv92","block_id") == 1 or pc.getf("collect_quest_lv96","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 1500, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv94","block_id",1)
							break
						end
					elseif 2== s2 then
						if pc.getf("collect_quest_lv92","block_id") == 2 or pc.getf("collect_quest_lv96","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 500, 60*60*24*365*60) 
							pc.setf("collect_quest_lv94","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv92","block_id") == 3 or pc.getf("collect_quest_lv96","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,200,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv94","block_id",3)
							break
						end
				    end
				end
			elseif selTab[s] == "92, 94 and 96 sky gem reward" then
				affect.remove_collect(1, 1000)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 300)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 100)
				pc.setf("collect_quest_lv92","block_id",0)
				affect.remove_collect(1, 1500)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 500)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 200)
				pc.setf("collect_quest_lv94","block_id",0)
				affect.remove_collect(1, 3000)
				affect.remove_collect(apply.DEF_GRADE_BONUS, 700)
				affect.remove_collect(apply.ATT_GRADE_BONUS, 300)
				pc.setf("collect_quest_lv96","block_id",0)

				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 92 Quest reward.")
					say("")
					s = select("Health +1000","Defence +300","Attack +100")
					if 1== s then
						if pc.getf("collect_quest_lv94","block_id") == 1 or pc.getf("collect_quest_lv96","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 1000, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv92","block_id",1)
							break
						end
					elseif 2== s then
						if pc.getf("collect_quest_lv94","block_id") == 2 or pc.getf("collect_quest_lv96","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 300, 60*60*24*365*60) 
							pc.setf("collect_quest_lv92","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv94","block_id") == 3 or pc.getf("collect_quest_lv96","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,100,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv92","block_id",3)
							break
						end
				    end
				end
				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 94 Quest reward.")
					say("")
					s2 = select("Health +1500","Defence +500","Attack +200")
					if 1== s2 then
						if pc.getf("collect_quest_lv92","block_id") == 1 or pc.getf("collect_quest_lv96","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 1500, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv94","block_id",1)
							break
						end
					elseif 2== s2 then
						if pc.getf("collect_quest_lv92","block_id") == 2 or pc.getf("collect_quest_lv96","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 500, 60*60*24*365*60) 
							pc.setf("collect_quest_lv94","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv92","block_id") == 3 or pc.getf("collect_quest_lv96","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,200,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv94","block_id",3)
							break
						end
				    end
				end
				while true do
					say_title("Seon-Pyeong:")
					say("")
					say("Please pick your new Level 96 Quest reward.")
					say("")
					s3 = select("Health +3000","Defence +700","Attack +300")
					if 1== s3 then
						if pc.getf("collect_quest_lv92","block_id") == 1 or pc.getf("collect_quest_lv94","block_id") == 1 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(1, 3000, 60*60*24*365*60) --hp+3000  hp is 1 
							pc.setf("collect_quest_lv96","block_id",1)
							break
						end
					elseif 2== s3 then
						if pc.getf("collect_quest_lv92","block_id") == 2 or pc.getf("collect_quest_lv94","block_id") == 2 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.DEF_GRADE_BONUS, 700, 60*60*24*365*60) 
							pc.setf("collect_quest_lv96","block_id",2)
							break
						end
					else 
						if pc.getf("collect_quest_lv92","block_id") == 3 or pc.getf("collect_quest_lv94","block_id") == 3 then
							say_white("You can not pick the same reward twice.")
							wait()
						else
							affect.add_collect(apply.ATT_GRADE_BONUS,300,60*60*24*365*60)--60years
							pc.setf("collect_quest_lv96","block_id",3)
							break
						end
					end
				end
			end
			pc.setqf( "collect_count", 0 )
			set_state( check_reset_able )

			say_title("Seon-Pyeong:")
			say("")
			say("I have changed the reward already.")
			say("Come look for me if you need to change again.")
			say("")
		end
	end
end