function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 33192, y = 31686, z = 14}) 
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 33192, y = 31686, z = 14}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 33192, y = 31686, z = 14})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 33192, y = 31686, z = 14}, 11)
end
