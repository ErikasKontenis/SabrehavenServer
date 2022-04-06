function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(17582) < os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your experience earnings have been enchanted by the Tibianus Gods.")
		player:setStorageValue(17582, os.time() + 24 * 60 * 60) -- 24 hour
		item:remove(1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You shoud not take any more today.")
	end
	return true
end
