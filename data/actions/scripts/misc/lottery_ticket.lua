function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if math.random(100) == 1 then
		player:getPosition():sendMagicEffect(CONST_ME_SOUND_YELLOW)
		player:say("Congratulations! You won a prize!", TALKTYPE_MONSTER_SAY)
		item:transform(5958)
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:say("Sorry, but you drew a blank.", TALKTYPE_MONSTER_SAY)
		item:remove(1)
	end
	return true
end
