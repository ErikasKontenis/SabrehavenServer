function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32222, y = 31094, z = 07})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32222, y = 31094, z = 07}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32222, y = 31094, z = 07})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32222, y = 31094, z = 07}, 11)
end
