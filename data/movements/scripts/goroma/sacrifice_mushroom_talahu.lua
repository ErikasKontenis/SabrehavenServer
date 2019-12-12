function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if Game.isItemThere({x = 31918, y = 32598, z = 10},3723) and Game.isItemThere({x = 31918, y = 32599, z = 10},3725) and Game.isItemThere({x = 31920, y = 32598, z = 10},3732) and Game.isItemThere({x = 31920, y = 32599, z = 10},3728) then
		Game.sendMagicEffect({x = 31918, y = 32598, z = 10}, 15)
		Game.removeItemOnMap({x = 31918, y = 32598, z = 10}, 3723)
		Game.sendMagicEffect({x = 31918, y = 32599, z = 10}, 15)
		Game.removeItemOnMap({x = 31918, y = 32599, z = 10}, 3725)
		Game.sendMagicEffect({x = 31920, y = 32598, z = 10}, 15)
		Game.removeItemOnMap({x = 31920, y = 32598, z = 10}, 3732)
		Game.sendMagicEffect({x = 31920, y = 32599, z = 10}, 15)
		Game.removeItemOnMap({x = 31920, y = 32599, z = 10}, 3728)
		
		doRelocate(item:getPosition(),{x = 31914, y = 32605, z = 10})
		item:getPosition():sendMagicEffect(11)
		Game.sendMagicEffect({x = 31914, y = 32605, z = 10}, 11)
	else
		doRelocate(item:getPosition(),{x = 31919, y = 32597, z = 10})
		item:getPosition():sendMagicEffect(11)
		Game.sendMagicEffect({x = 31919, y = 32597, z = 10}, 11)
	end
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 31915, y = 32606, z = 10})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 31915, y = 32606, z = 10}, 11)
end
