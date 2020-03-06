function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if fromPosition.x ~= CONTAINER_POSITION then
		fromPosition:sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
	else
		local pos = player:getPosition()
		pos:sendMagicEffect(CONST_ME_HITBYFIRE)
		pos:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		player:say("Ouch! Rather place it on the ground next time.", TALKTYPE_MONSTER_SAY)
		if (player:getHealth() > 10) then
			player:addHealth(-10)
		end
	end

	item:remove()

	return true
end
