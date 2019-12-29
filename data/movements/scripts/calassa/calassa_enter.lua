function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local headItem = player:getSlotItem(CONST_SLOT_HEAD)
	if headItem and isInArray({5460}, headItem.itemid) then
		player:teleportTo(Position(31915, 32716, 12))
		player:getPosition():sendMagicEffect(2)
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	else
		position.y = position.y - 3
		player:teleportTo(position)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 31915, y = 32716, z = 12})
	Game.sendMagicEffect({x = 31915, y = 32716, z = 12}, 2)
end