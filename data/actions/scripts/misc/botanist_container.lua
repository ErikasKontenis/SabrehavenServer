function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	if target:getId() == 3874 and player:getStorageValue(305) == 1 then
		item:transform(4868, 1)
		target:getPosition():sendMagicEffect(10)
		return true
	elseif target:getId() == 3885 and player:getStorageValue(305) == 3 then
		item:transform(4870, 1)
		target:getPosition():sendMagicEffect(10)
		return true
	elseif target:getId() == 3878 and player:getStorageValue(305) == 5 then 
		item:transform(4869, 1)
		target:getPosition():sendMagicEffect(10)
		return true
	elseif target:getId() == 5658 and player:getStorageValue(17535) == 1 then 
		if player:getStorageValue(17536) < os.time() then
			item:transform(5937, 1)
			target:getPosition():sendMagicEffect(10)
			player:setStorageValue(17536, os.time() + 20 * 60 * 60) -- 20 hour
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You just collected a fragile griffinclaw. At least wait for the rest of the plant to recover a bit before gathering more.")
			return true
		end
	end
	return false
end
