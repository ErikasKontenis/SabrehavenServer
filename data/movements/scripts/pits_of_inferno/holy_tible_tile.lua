local destinations = {
	[17640] = Position(32791, 32327, 10),
	[17641] = Position(32791, 32331, 10)
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if player:getItemCount(2836) < 1 then
		player:teleportTo(fromPosition)
		return true
	end

	player:teleportTo(destinations[item:getMovementId()])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
