function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32121, y = 32693, z = 04})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32121, y = 32693, z = 04}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32121, y = 32693, z = 04})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32121, y = 32693, z = 04}, 11)
end
