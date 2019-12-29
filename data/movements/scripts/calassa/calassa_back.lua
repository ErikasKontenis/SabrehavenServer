function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 31914, y = 32713, z = 6})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31914, y = 32713, z = 6}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 31914, y = 32713, z = 6})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31914, y = 32713, z = 6}, 11)
end
