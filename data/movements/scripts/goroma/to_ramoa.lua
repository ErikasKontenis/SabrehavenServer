function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(17510) ~= 1 then
		Game.sendMagicEffect({x = 32043, y = 32559, z = 08}, 11)
		player:teleportTo({x = 32043, y = 32559, z = 08}) 
		return true
	end

	doRelocate(item:getPosition(),{x = 31948, y = 32554, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31948, y = 32554, z = 08}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 31948, y = 32554, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31948, y = 32554, z = 08}, 11)
end
