function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(17509) < 5 then
		position:sendMagicEffect(CONST_ME_ENERGYHIT)

		position.x = position.x + 2
		player:teleportTo(position)
		return true
	end

	return true
end
