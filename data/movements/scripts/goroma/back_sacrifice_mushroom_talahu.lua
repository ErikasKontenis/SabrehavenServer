function onStepIn(creature, item, position, fromPosition)
	doRelocate(item:getPosition(),{x = 31919, y = 32594, z = 10})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31919, y = 32594, z = 10}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 31919, y = 32594, z = 10})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31919, y = 32594, z = 10}, 11)
end
