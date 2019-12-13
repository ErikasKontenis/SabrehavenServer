local config = {
	[51191] = Position(32359, 32901, 7),
	[51192] = Position(32340, 32538, 7),
	[51193] = Position(32472, 32869, 7),
	[51194] = Position(32415, 32916, 7),
	[51195] = Position(32490, 32979, 7),
	[51196] = Position(32440, 32971, 7),
	[51197] = Position(32523, 32923, 7),
	[51198] = Position(32527, 32951, 7)
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = config[item:getMovementId()]
	if not targetPosition then
		return true
	end

	if item:getMovementId() == 51191 and player:getStorageValue(17502) < 13 then
		player:teleportTo(Position(32340, 32540, 7))
		position:sendMagicEffect(CONST_ME_TELEPORT)
		Position(32340, 32540, 7):sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	player:teleportTo(targetPosition)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end