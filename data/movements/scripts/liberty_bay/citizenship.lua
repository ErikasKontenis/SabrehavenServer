function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then 
		doRelocate(item:getPosition(),{x = 32317, y = 32826, z = 07})
		creature:getPlayer():setTown(Town("Liberty Bay"))
		Game.sendMagicEffect({x = 32317, y = 32826, z = 07}, 13)
	end
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32313, y = 32819, z = 07})
	Game.sendMagicEffect({x = 32313, y = 32819, z = 07}, 14)
end
