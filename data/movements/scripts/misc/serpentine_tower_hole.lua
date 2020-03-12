function onAddItem(item, tileitem, position)
	if item:getId() == 5898 then
		tileitem:getPosition():sendMonsterSay("MORE! MORE!")
		item:remove(-1)
		return true
	elseif item:getId() == 5776 then
		tileitem:getPosition():sendMonsterSay("OHHH! WILL USE IT LATER!")
		item:remove(-1)
		return true
	end
	
	tileitem:getPosition():sendMonsterSay("I WANT EYES!")
	item:remove(-1)
end