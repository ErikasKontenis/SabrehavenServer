function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(17569) ~= 1 then
		player:setStorageValue(17569, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a hydra egg.")
		player:addItem(4839, 1)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The " .. item:getName() .. " is empty.")
	end

	return true
end