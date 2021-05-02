function onLogin(player)
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit on " .. configManager.getString(configKeys.SERVER_NAME) .. ": %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	
	if not player:isPremium() then
		local dayNow = tonumber(os.date("%d", os.time()))
		local hourNow = tonumber(os.date("%H", os.time()))
		if dayNow == 8 and hourNow == 20 then
			player:addPremiumDays(5)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations " .. player:getName() .. " on starting your adventure at the " .. configManager.getString(configKeys.SERVER_NAME) .. "! 5 premium days have been added to your account!")
		elseif dayNow == 8 then
			player:addPremiumDays(2)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations " .. player:getName() .. " on starting your adventure at the " .. configManager.getString(configKeys.SERVER_NAME) .. "! 2 premium days have been added to your account!")
		end
	end
	
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	
	-- Stamina
	nextUseStaminaTime[player.uid] = 0
	
	-- Promotion
	if player:getVocation():getId() ~= 0 and player:getVocation():getId() < 5 and player:getStorageValue(30018) == 1 then
		player:setVocation(player:getVocation():getId() + 4)
	end

	-- Premium system
	if player:isPremium() then
		player:setStorageValue(43434, 1)
	elseif player:getStorageValue(43434) == 1 then
		player:setStorageValue(43434, 0)
	end
	
	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("kills")
	player:registerEvent("PlayerLogout")
	player:registerEvent("FirstItems")
	player:registerEvent("RegenerateStamina")
	
	return true
end
