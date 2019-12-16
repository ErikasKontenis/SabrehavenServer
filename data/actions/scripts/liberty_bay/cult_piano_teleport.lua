local storages = {1053, 1054, 1055, 1056}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPosition = player:getPosition()
	
	for i = 1, #storages do	
		if player:getStorageValue(storages[i]) ~= 1 then
			player:say("You have not learned all the verses of the hymn.", TALKTYPE_MONSTER_SAY, false, 0, toPosition)
			playerPosition:sendMagicEffect(CONST_ME_POFF)
			return true
		end
	end

	player:teleportTo(Position(32402, 32794, 9))
	player:say("You have sucessfully played the secret hymn of the cult.", TALKTYPE_MONSTER_SAY)
	Game.sendMagicEffect({x = 32402, y = 32794, z = 9}, CONST_ME_SOUND_PURPLE)
	return true
end