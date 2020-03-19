function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == 2772 and Game.isItemThere({x = 33147, y = 32862, z = 9}, 3246) and Game.isItemThere({x = 33144, y = 32868, z = 8}, 1653) and getGlobalStorageValue(21411) == -1 then 
		item:transform(2773, 1)
		item:decay()
		Game.sendMagicEffect({x = 33147, y = 32862, z = 9}, CONST_ME_SOUND_WHITE)
		Game.sendMagicEffect({x = 33145, y = 32870, z = 8}, CONST_ME_SOUND_YELLOW)
		doRelocate({x = 33147, y = 32862, z = 9}, {x = 33145, y = 32870, z = 8})
		Game.removeItemOnMap({x = 33144, y = 32868, z = 8}, 1653)
		Game.createItem(1654, 1, {x = 33144, y = 32868, z = 8})
		setGlobalStorageValue(21411, 1)
		player:setStorageValue(17605, 1)
		broadcastMessage("The player " .. player:getName() .. " have solved the Serpentine Tower!", MESSAGE_STATUS_WARNING)
	elseif item:getId() == 2773 then 
		item:transform(2772, 1)
		item:decay()
	end
	return true
end