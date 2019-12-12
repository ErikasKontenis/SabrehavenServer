function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32124, y = 32694, z = 05})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32124, y = 32694, z = 05}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32124, y = 32694, z = 05})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32124, y = 32694, z = 05}, 11)
end
