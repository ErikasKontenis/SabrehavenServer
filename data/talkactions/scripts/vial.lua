function onSay(player, words, param)
	if player:getStorageValue(17742) ~= 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Vials auto removing enabled.")
		player:setStorageValue(17742, 1)
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Vials auto removing disabled.")
		player:setStorageValue(17742, 0)
	end
	return false
end
