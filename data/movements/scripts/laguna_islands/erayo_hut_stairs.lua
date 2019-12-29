function onStepIn(creature, item, position, fromPosition)
	if creature:getCondition(CONDITION_INVISIBLE, CONDITIONID_COMBAT) or creature:getCondition(CONDITION_INVISIBLE, CONDITIONID_RING) then
		if item:getId() == 485 then
			doRelocate(item:getPosition(),{x = 32517, y = 32910, z = 8})
		elseif item:getId() == 1947 then
			doRelocate(item:getPosition(),{x = 32517, y = 32908, z = 7})
		end
		
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32519, y = 32914, z = 7})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32519, y = 32914, z = 7}, 11)
	creature:say("Why are you sneaking around in my house? Think I don't see you?", TALKTYPE_MONSTER_SAY, false, 0, creature:getPosition())
end