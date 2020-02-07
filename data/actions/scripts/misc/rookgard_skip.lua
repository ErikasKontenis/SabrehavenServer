function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(17572) ~= 1 and player:getLevel() <= 7 then
		player:setStorageValue(17572, 1)
		player:addHealth(-math.random(player:getHealth()-20, player:getHealth()-1))
		item:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
		player:say('OUCH!', TALKTYPE_MONSTER_SAY)
		player:addExperience(4200 - player:getExperience())
		
		player:addItem(3355,1)
		player:addItem(3361,1)
		player:addItem(3559,1)
		player:addItem(3552,1)
		player:addItem(3412,1)
		player:addItem(3273,1)
		player:addItem(3031,25)
		player:addItem(3582,3)
		player:addItem(3003,1)
	end

	return true
end