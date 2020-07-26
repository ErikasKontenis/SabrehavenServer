function onAddItem(item, tileitem, position)
	if item:getId() == 2918 or item:getId() == 2917 then
		tileitem:transform(6279, 1)
		item:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		item:remove()
	end
	return true
end