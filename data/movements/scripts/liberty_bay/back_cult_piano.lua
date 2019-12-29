function onStepIn(creature, item, position, fromPosition)
	doRelocate(item:getPosition(),{x = 32410, y = 32794, z = 9})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32410, y = 32794, z = 9}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32410, y = 32794, z = 9})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32410, y = 32794, z = 9}, 11)
end
