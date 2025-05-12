if npc . is_pc ( ) == false then local unknown_stone_count = pc . getqf ( "unknown_stone_count" ) 
if number ( 1 , 4 ) == 1 then 
pc . setqf ( "unknown_stone_count" , unknown_stone_count + 1 ) 
pc . give_item2 ( 31093 ) 
unknown_stone . unknown_stone_counter ( ) 
end 
 return end 