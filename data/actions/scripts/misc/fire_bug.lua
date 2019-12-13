function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(17520) == 5 and target.itemid == 5601 then
		player:setStorageValue(17520, 6)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		return true
	end
	
	local random = math.random(10)
	if random >= 4 then --success 6% chance
		if target.itemid == 5465 then --Burn Sugar Cane
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			target:transform(5464)
			target:decay()
		elseif target.itemid == 3514 then --Light Up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(3513)
		elseif target.itemid == 2114 then --Light Up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(2113)
		end
	elseif random == 2 then --it remove the fire bug 2% chance
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif random == 1 then --it explode on the user 1% chance
		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say('OUCH!', TALKTYPE_MONSTER_SAY)
		item:remove(1)
	else
		toPosition:sendMagicEffect(CONST_ME_POFF) --it fails, but dont get removed 3% chance
	end
	return true
end
