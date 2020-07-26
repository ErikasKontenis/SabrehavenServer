function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == 2931 and Game.isItemThere({x = 33151, y = 32868, z = 8}, 1345) then 
		Game.removeItemOnMap({x = 33151, y = 32868, z = 8}, 1345)
		Game.sendMagicEffect({x = 33145, y = 32865, z = 8}, 14)
	elseif item:getId() == 2931 then 
		Game.sendMagicEffect({x = 33145, y = 32865, z = 8}, 3)
	end
	return true
end