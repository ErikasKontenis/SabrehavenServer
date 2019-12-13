function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	position.y = position.y - 1
	player:teleportTo(position)

	return true
end
