function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(17605) ~= 1 and Game.isItemThere({x = 33145, y = 32870, z = 8}, 3246) then
		position.y = position.y - 5
		player:teleportTo(position)
		Game.sendMagicEffect(player:getPosition(), CONST_ME_HITAREA)
		Position(33145, 32870, 8):sendMonsterSay("Only the humble can touch the boots!")
		return true
	end

	return true
end
