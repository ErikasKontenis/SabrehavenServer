function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getOutfit().lookType ~= 17 then
		position.y = position.y + 1
		player:teleportTo(position)
		Game.sendMagicEffect(player:getPosition(), CONST_ME_ENERGYHIT)
		player:addHealth(-20)
		return true
	end

	return true
end
