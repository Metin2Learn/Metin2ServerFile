quest resetlanguage begin
	state start begin
		function Information(want)
			if(want == "letter") then
				local translate = {
					[1] = {"Dilini De�i�tir"},
					[2] = {"Change the language"},
					[3] = {" �ndern Sie die Sprache"},
					[4] = {"Cambiar el idioma"},
				},
				return translate[pc.getqf("language_select")][1]
			elseif(want == "info") then
				local translate = {
					[1] = {"Dilini de�i�tirmek istiyor musun? "},
					[2] = {"Do you want to change the language? "},
					[3] = {"M�chten Sie die Sprache �ndern? "},
					[4] = {" �Quieres cambiar el idioma? "},
				}
				return translate[pc.getqf("language_select")][1]
			elseif(want == "succ") then
				local translate = {
					[1] = {"Dilinizi de�i�tirildi.[ENTER]L�tfen dilinizi se�in. "},
					[2] = {"Your language has been changed.[ENTER]Please select your language. "},
					[3] = {" Ihre Sprache wurde ge�ndert.[ENTER]Bitte w�hlen Sie Ihre Sprache. "},
					[4] = {"Su lenguaje se ha cambiado.[ENTER]Por favor seleccione su idioma. "}
				}
				return translate[pc.getqf("language_select")[1]
			end
		end
		
		when letter with pc.getqf("language_select") != 0 begin
			send_letter(resetlanguage.Information("letter"))
		end
		when button or info begin
			say_title(resetlanguage.Information("letter"))
			say("")
			---
			say(resetlanguage.Information("info"))
			say("")
			local s = select(locale.yes,locale.no)
			if(s == 2) then
				return
			end
			say_title(resetlanguage.Information("letter"))
			say("")
			---
			say(resetlanguage.Information("succ"))
			say("")
			set_state(information)
		end
	end
	
	state information begin
		when letter begin
			send_letter("Reset language")
		end
		when button or info begin
			say_title("Reset language: ")
			say("")
			---
			say("Please select your language. ")
			local translate = {
				[1] = {"T�rk�e"," �ngilizce","Almanca"," �spanyolca","Kapat"},
				[2] = {"Turkish","English","Germany","Spanish","Close"},
				[3] = {"T�rkisch","Englisch","Deutsch","Spanisch","Schlie�en"},
				[4] = {"Turko","Ingl�s","Alem�n","Espa�ol","Secuestrado"},
			}
			local s = select_table(translate[pc.getqf("langauge_select")])
			if(table.getn(translate[pc.getqf("language_select")]) == s) then
				return
			elseif(table.getn(translate[pc.getqf("language_select")]) >= s) then
				say_title(translate[pc.getqf("language")][s].." Chosen")
				say("")
				---
				pc.setqf("language_select",translate[pc.getqf("language")][s])
				say("Now you will be see the tasks "..translate[pc.getqf("language")][s])
				say("Thank you. ")
				say_reward("World Of Metin2 Team. ")
				clear_letter()
			end
		end
	end
end
