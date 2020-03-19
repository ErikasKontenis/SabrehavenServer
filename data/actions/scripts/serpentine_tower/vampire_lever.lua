function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == 2772 and Game.isItemThere({x = 33145, y = 32863, z = 8}, 1650) then
		Game.removeItemOnMap({x = 33145, y = 32863, z = 8}, 1650)
		Game.createItem(1651, 1, {x = 33145, y = 32863, z = 8})
	end
	return true
end