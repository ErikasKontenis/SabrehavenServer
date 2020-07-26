function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2772 then
		player:teleportTo(Position(32806, 32328, 15))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		item:transform(2773)
 	end
 	return true
end
