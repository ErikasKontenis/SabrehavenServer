function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(17513) ~= 2 then
		player:setStorageValue(17513, 1) 
		doRelocate(item:getPosition(),{x = 32121, y = 32709, z = 7})
		Game.sendMagicEffect({x = 32121, y = 32709, z = 7}, 11)
		
		local isInGhostMode = player:isInGhostMode()
		local spectators = Game.getSpectators(player:getPosition(), false, true, 3, 3)
		for i = 1, #spectators do
			player:say("This entrance has been sealed by the Edron Academy.", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], player:getPosition())
		end
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32121, y = 32703, z = 7})
	Game.sendMagicEffect({x = 32121, y = 32703, z = 7}, 11)
	player:setStorageValue(17513, 1) 

	return true
end
