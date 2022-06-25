function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(12190) == 2 and player:getStorageValue(12194) <= 20 then
		if math.random(5) > 1 then
			player:say('The world seems to spin but you manage to stay on your feet.', TALKTYPE_MONSTER_SAY)
			player:setStorageValue(12195, player:getStorageValue(12195) + 1)
			if player:getStorageValue(12195) == 9 then -- 9 sips here cause local player at start
				player:say('10 sips in a row. Yeah!', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(12190, 3)
				player:setStorageValue(12191, 3) -- Questlog Barbarian Test Quest Barbarian Test 1: Barbarian Booze
				return true
			end
		else
			player:say('The mead was too strong. You passed out for a moment.', TALKTYPE_MONSTER_SAY)
			player:setStorageValue(12195, 0)
		end
		player:setStorageValue(12194, player:getStorageValue(12194) + 1)
	elseif player:getStorageValue(12194) > 20 then
		player:say('Ask Sven for another round.', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(12190, 1)
		player:setStorageValue(12191, 1) -- Questlog Barbarian Test Quest Barbarian Test 1: Barbarian Booze
	elseif player:getStorageValue(12190) >= 3 then
		player:say('You already passed the test, no need to torture yourself anymore.', TALKTYPE_MONSTER_SAY)
	end
	return true
end