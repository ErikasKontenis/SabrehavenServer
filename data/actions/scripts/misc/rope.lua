local ropeSpots = {
	386, 421
}

local holeSpots = {
	293, 294, 369, 370, 385, 394, 411, 412,
	421, 432, 433, 435, 482, 5081, 483, 594,
	595, 607, 609, 610, 615, 1066, 1067, 1080
}

local pools = {2886, 2887, 2888, 2889, 2890, 2891, 2895, 2896, 2897, 2898, 2899, 2900}

function onUse(player, item, fromPosition, target, toPosition)
	if (configManager.getBoolean(configKeys.ROPE_SPOT_BLOCK)) then
		-- Rope for 7.4 protocol.
		local newPos = {x = toPosition.x, y = toPosition.y, z = toPosition.z, stackpos = 0}
		local groundItem = getThingfromPos(newPos)
		local blockingItem = getThingfromPos({x = toPosition.x, y = toPosition.y, z = toPosition.z, stackpos = 255})
		if table.contains(ropeSpots, groundItem.itemid) then
			newPos.y = newPos.y + 1
			newPos.z = newPos.z - 1
			if((blockingItem.itemid > 0 and not isInArray(pools, blockingItem.itemid)) or isCreature(blockingItem.uid)) then
				doPlayerSendCancel(player, "You cannot use this object.")
			else
				doTeleportThing(player, newPos)
			end
		elseif table.contains(holeSpots, groundItem.itemid) then
			newPos.y = newPos.y + 1
			local downPos = {x = toPosition.x, y = toPosition.y, z = toPosition.z + 1, stackpos = 255}
			local downItem = getThingfromPos(downPos)
			if(downItem.itemid > 0) then
				doTeleportThing(downItem.uid, newPos)
			else
				doPlayerSendCancel(player, "You cannot use this object.")
			end
		end
		return true
	else
		local tile = Tile(toPosition)
		if not tile then
			return false
		end
		
		if not tile:getGround() then
			return false
		end
		
		if table.contains(ropeSpots, tile:getGround():getId()) then
			player:teleportTo(target:getPosition():moveRel(0, 1, -1))
			return true
		elseif table.contains(holeSpots, tile:getGround():getId()) or target:getId() == 435 then
			local tile = Tile(target:getPosition():moveRel(0, 0, 1))
			if not tile then
				return false
			end
			
			local thing = tile:getTopCreature()
			if not thing then
				thing = tile:getTopVisibleThing()
			end
			
			if thing:isCreature() then
				thing:teleportTo(target:getPosition():moveRel(0, 1, 0), false)
				return true
			end
			if thing:isItem() and thing:getType():isMovable() then
				thing:moveTo(target:getPosition():moveRel(0, 1, 0))
				return true
			end
			return true
		end
		return false
	end
	
	return true
end