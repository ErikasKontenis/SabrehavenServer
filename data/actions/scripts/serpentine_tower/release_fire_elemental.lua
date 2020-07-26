function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == 2929 and Game.isItemThere({x = 33151, y = 32866, z = 08},1345) then 
		Game.removeItemOnMap({x = 33151, y = 32866, z = 08}, 1345)
		Game.sendMagicEffect({x = 33148, y = 32861, z = 8}, 14)
	elseif item:getId() == 2929 then 
		Game.sendMagicEffect({x = 33148, y = 32861, z = 8}, 3)
	end
	return true
end