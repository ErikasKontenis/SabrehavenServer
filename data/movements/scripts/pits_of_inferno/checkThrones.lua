local cStorages = {
	[2090] = 17679, -- ThroneInfernatil
	[2091] = 17680, -- ThroneTafariel
	[2092] = 17681, -- ThroneVerminor
	[2093] = 17682, -- ThroneApocalypse
	[2094] = 17683, -- ThroneBazir
	[2095] = 17684, -- ThroneAshfalor
	[2096] = 17685 -- ThronePumin
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(cStorages[item:getMovementId()]) ~= 1 then
		player:teleportTo(fromPosition)
		player:say('You\'ve not absorbed energy from this throne.', TALKTYPE_MONSTER_SAY)
	end
	return true
end
