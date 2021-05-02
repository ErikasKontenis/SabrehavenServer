local fakePlayers = {
	{x = 32864, y = 31997, z = 7},
	{x = 32864, y = 31998, z = 7},
	{x = 32865, y = 31999, z = 7},
	{x = 32871, y = 31999, z = 7},
	{x = 32872, y = 32000, z = 7},
	{x = 32825, y = 32065, z = 7},
	{x = 32828, y = 32065, z = 7},
	{x = 32885, y = 32050, z = 7},
	{x = 32885, y = 32049, z = 7},
	{x = 32823, y = 31887, z = 7},
	{x = 32691, y = 31716, z = 7},
	{x = 32705, y = 31787, z = 7},
	{x = 32716, y = 31928, z = 7},
	{x = 32880, y = 31845, z = 7},
	{x = 32879, y = 31845, z = 7},
	{x = 32882, y = 31840, z = 7},
	{x = 32655, y = 32109, z = 8},
	{x = 32665, y = 32109, z = 8},
	{x = 32254, y = 32019, z = 7},
	{x = 32255, y = 32020, z = 7},
	{x = 32245, y = 32021, z = 7},
	{x = 32238, y = 32330, z = 7},
	{x = 32238, y = 32331, z = 7},
	{x = 32273, y = 32396, z = 7},
	{x = 32465, y = 32315, z = 7},
	{x = 32225, y = 31740, z = 7},
	{x = 32230, y = 31739, z = 7},
	{x = 32257, y = 31838, z = 7},
	{x = 32258, y = 31840, z = 7},
	{x = 32258, y = 31844, z = 7},
	{x = 32260, y = 31846, z = 7},
	{x = 32261, y = 31848, z = 7},
	{x = 32231, y = 31701, z = 7},
	{x = 32516, y = 31599, z = 7},
	{x = 32486, y = 31590, z = 7},
	{x = 32493, y = 31590, z = 7},
	{x = 32503, y = 31670, z = 7},
	{x = 32579, y = 31928, z = 0},
	{x = 32596, y = 31922, z = 0},
	{x = 32621, y = 31921, z = 1},
	{x = 32651, y = 31942, z = 7},
	{x = 32531, y = 32721, z = 7},
	{x = 32531, y = 32720, z = 7},
	{x = 32530, y = 32720, z = 7},
	{x = 32537, y = 32813, z = 7},
	{x = 32537, y = 32814, z = 7},
	{x = 32537, y = 32759, z = 7},
	{x = 32538, y = 32759, z = 7},
	{x = 33023, y = 32872, z = 7},
	{x = 33023, y = 32871, z = 7},
	{x = 33023, y = 32870, z = 7},
	{x = 33275, y = 32829, z = 7},
	{x = 33238, y = 32555, z = 7},
	{x = 33237, y = 32555, z = 7},
	{x = 33187, y = 32343, z = 7},
	{x = 33187, y = 32342, z = 7},
	{x = 33152, y = 32354, z = 7},
	{x = 33154, y = 32354, z = 7},
	{x = 33076, y = 32345, z = 7},
	{x = 32655, y = 31648, z = 10},
	{x = 32656, y = 31648, z = 10},
	{x = 32657, y = 31648, z = 10},
	{x = 33262, y = 31866, z = 7},
	{x = 33263, y = 31866, z = 7},
	{x = 33244, y = 31904, z = 7},
	{x = 33245, y = 31903, z = 7},
	{x = 33219, y = 31926, z = 7},
	{x = 33298, y = 31839, z = 7},
	{x = 33298, y = 31838, z = 7},
	{x = 33358, y = 31692, z = 9},
	{x = 33359, y = 31692, z = 9},
	{x = 33360, y = 31692, z = 9},
	{x = 33362, y = 31696, z = 9},
	{x = 33366, y = 31696, z = 9},
	{x = 33318, y = 31728, z = 7},
	{x = 33318, y = 31729, z = 7},
	{x = 33273, y = 31680, z = 7},
	{x = 33169, y = 31737, z = 7},
	{x = 33274, y = 31791, z = 6},
	{x = 33321, y = 32419, z = 7},
	{x = 33318, y = 32406, z = 7},
	{x = 32372, y = 32840, z = 7},
	{x = 32371, y = 32839, z = 7},
	{x = 32369, y = 32838, z = 7},
	{x = 32347, y = 32691, z = 7},
	{x = 32348, y = 32692, z = 7},
	{x = 32157, y = 32783, z = 7},
	{x = 32225, y = 32880, z = 7},
	{x = 32386, y = 32695, z = 7},
	{x = 32314, y = 32830, z = 8},
	{x = 32593, y = 31885, z = 12},
	{x = 32593, y = 31884, z = 12},
	{x = 32586, y = 31919, z = 10},
	{x = 32547, y = 31921, z = 10},
	{x = 32763, y = 31941, z = 7},
	{x = 32763, y = 31942, z = 7},
	{x = 32700, y = 31842, z = 7},
	{x = 32700, y = 31841, z = 7},
	{x = 32991, y = 32377, z = 7},
	{x = 32314, y = 32282, z = 7}
}



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
	
	-- FakePlayer
	if player:isFakePlayer() then
		local inFightCondition = Condition(CONDITION_INFIGHT)
		inFightCondition:setParameter(CONDITION_PARAM_TICKS, 2000 * 60 * 1000)
		player:addCondition(inFightCondition)
		player:teleportTo(fakePlayers[1])
		table.remove(fakePlayers, 1)
		-- TODO give random bps, lvls, mls
	end
	
	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("kills")
	player:registerEvent("PlayerLogout")
	player:registerEvent("FirstItems")
	player:registerEvent("RegenerateStamina")
	
	return true
end
