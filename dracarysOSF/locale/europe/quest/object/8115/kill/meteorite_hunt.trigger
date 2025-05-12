local kill_count = pc . getqf ( "hunted_meteorites" ) 
pc . setqf ( "hunted_meteorites" , kill_count + 1 ) 
pc . give_item2 ( 31094 ) 
meteorite_hunt . meteorite_hunt_kill_count ( ) 
