quest language begin
	state start begin
		when login or levelup with pc.getqf("language_select") == 0 begin
			set_state(information)
		end
	end
	
	state information begin
		when letter begin
			send_letter("Select language")
		end
		when button or info begin
			say_title("Select language: ")
			say("")
			---
			say("Hello "..pc.name..",")
			say("Please select your language. ")
			say_reward("")
			local s = select("Turkish","English","Germany","Spanish","Close")
			local language_list = {"Turkish","English","Germany","Spanish"}
			if(s == 7) then
				return
			end
			say_title(language_list[s].." Chosen")
			say("")
			---
			pc.setqf("language_select",s)
			say("Now you will be see the tasks "..language_list[s])
			say("Thank you. ")
			say_reward("World Of Metin2 Team. ")
			clear_letter()
		end
	end
end
