function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- The Shattered Isles Parrot ring
	if target:getId() == 6094 then
		if player:getStorageValue(17502) == 1 and player:getStorageValue(17503) ~= 1 then
			toPosition:sendMagicEffect(CONST_ME_POFF)
			Game.createItem(6093, 1, Position(32422, 32770, 1))
			player:say("You have found a ring.", TALKTYPE_MONSTER_SAY)
			player:setStorageValue(17503, 1)
		end
	end
	return true
end
