function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(17572) ~= 1 and player:getLevel() <= 7 then
		player:setStorageValue(17572, 1)
		player:addHealth(-math.random(player:getHealth()-20, player:getHealth()-1))
		item:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
		player:say('OUCH!', TALKTYPE_MONSTER_SAY)
		player:addExperience(4200 - player:getExperience())
	end

	return true
end