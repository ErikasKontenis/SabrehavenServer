function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local portal = Tile(Position(32816, 32345, 13)):getItemById(1949)
	if not portal then
		local item = Game.createItem(1949, 1, Position(32816, 32345, 13))
		item:setMovementId(17686)
	else
		portal:remove()
	end
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end
