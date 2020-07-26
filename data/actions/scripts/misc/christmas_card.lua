function onUse(player, item, fromPosition, target, toPosition)
	item:getPosition():sendMagicEffect(CONST_ME_SOUND_YELLOW)
	item:getPosition():sendMonsterSay("Merry Christmas, " .. player:getName() .. "!")
	return true
end
