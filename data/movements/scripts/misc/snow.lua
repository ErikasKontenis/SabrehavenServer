function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player and player:isInGhostMode() then
		return true
	end
	
	local tile = Tile(position)
	if tile == nil or tile:hasProperty(CONST_PROP_HASHEIGHT) then
		return true
	end
	
	if item.itemid == 799 then
		item:transform(6594)
	else
		item:transform(item.itemid + 15)
	end
	item:decay()
	return true
end