function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32818, y = 32344, z = 13})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32818, y = 32344, z = 13}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32818, y = 32344, z = 13})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32818, y = 32344, z = 13}, 11)
end
