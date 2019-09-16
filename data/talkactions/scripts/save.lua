function onSay(player, words, param)

	local function timeSave(delay, msg)
		broadcastMessage(msg, MESSAGE_STATUS_WARNING)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
		addEvent(saveServer, delay)
	end

    if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	if isNumber(param) then
		local delay = tonumber(param) * 1000
		timeSave(delay, "Saving server in " .. tonumber(param) .. " seconds.")
	else
		saveServer()
	end
end