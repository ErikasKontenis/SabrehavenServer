function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	if target:getId() == 5662 and Game.isItemThere({x = 33024, y = 32672, z = 6}, 5662) then
		item:transform(5939, 1)
		target:getPosition():sendMagicEffect(2)
		return true
	end
	return false
end
