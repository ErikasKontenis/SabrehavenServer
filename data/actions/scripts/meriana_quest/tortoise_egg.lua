function onUse(player, item, fromPosition, target, toPosition)
	if player:getStorageValue(17526) < os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a tortoise egg from Nargor.")
		player:setStorageValue(17526, os.time() + 24 * 60 * 60) -- 24 hour
		player:addItem(6125,1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You shoud not take any more today.")
	end
	return true
end
