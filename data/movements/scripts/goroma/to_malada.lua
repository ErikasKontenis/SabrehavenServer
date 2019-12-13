function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(17512) ~= 1 then
		Game.sendMagicEffect({x = 31926, y = 32656, z = 08}, 11)
		player:teleportTo({x = 31926, y = 32656, z = 08}) 
		return true
	end

	doRelocate(item:getPosition(),{x = 32021, y = 32680, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32021, y = 32680, z = 08}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32021, y = 32680, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32021, y = 32680, z = 08}, 11)
end
