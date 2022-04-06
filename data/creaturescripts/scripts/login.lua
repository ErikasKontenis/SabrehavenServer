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
	{x = 32314, y = 32282, z = 7},
	{x = 32659, y = 31632, z = 15},
	{x = 32660, y = 31632, z = 15},
	{x = 32661, y = 31632, z = 15},
	{x = 32663, y = 31632, z = 15},
	{x = 32661, y = 31634, z = 15},
	{x = 32714, y = 31649, z = 15},
	{x = 32715, y = 31649, z = 15},
	{x = 32716, y = 31649, z = 15},
	{x = 32717, y = 31649, z = 15},
	{x = 32577, y = 31601, z = 11},
	{x = 32577, y = 31602, z = 11},
	{x = 32577, y = 31603, z = 11},
	{x = 32577, y = 31604, z = 11},
	{x = 32577, y = 31605, z = 11},
	{x = 32602, y = 31611, z = 11},
	{x = 32601, y = 31611, z = 11},
	{x = 32600, y = 31610, z = 11},
	{x = 32599, y = 31610, z = 11},
	{x = 32598, y = 31609, z = 11},
	{x = 32598, y = 31608, z = 11},
	{x = 32604, y = 31670, z = 7},
	{x = 32605, y = 31670, z = 7},
	{x = 32606, y = 31670, z = 7},
	{x = 32607, y = 31670, z = 7},
	{x = 32608, y = 31670, z = 7},
	{x = 32609, y = 31670, z = 7},
	{x = 32537, y = 31772, z = 4},
	{x = 32537, y = 31772, z = 3},
	{x = 32382, y = 32130, z = 10},
	{x = 32410, y = 32123, z = 10},
	{x = 32408, y = 32123, z = 10},
	{x = 32445, y = 32213, z = 8},
	{x = 32445, y = 32212, z = 8},
	{x = 32444, y = 32210, z = 8},
	{x = 32392, y = 31805, z = 8},
	{x = 32127, y = 31660, z = 8},
	{x = 32127, y = 31659, z = 8},
	{x = 32187, y = 31623, z = 4},
	{x = 32188, y = 31623, z = 4},
	{x = 32189, y = 31623, z = 4},
	{x = 32189, y = 31624, z = 4},
	{x = 32187, y = 31625, z = 4},
	{x = 32190, y = 31656, z = 7},
	{x = 32030, y = 31691, z = 7},
	{x = 32030, y = 31692, z = 7},
	{x = 32030, y = 31693, z = 7},
	{x = 31960, y = 31583, z = 7},
	{x = 31960, y = 31584, z = 7},
	{x = 31961, y = 31585, z = 7},
	{x = 31961, y = 31582, z = 7},
	{x = 32029, y = 31536, z = 10},
	{x = 32258, y = 31641, z = 7},
	{x = 32316, y = 31747, z = 2},
	{x = 32317, y = 31747, z = 2},
	{x = 32910, y = 32085, z = 5},
	{x = 33021, y = 32046, z = 5},
	{x = 32978, y = 32254, z = 7},
	{x = 32977, y = 32254, z = 7},
	{x = 32976, y = 32254, z = 7},
	{x = 32975, y = 32254, z = 7},
	{x = 32974, y = 32254, z = 7},
	{x = 32950, y = 32271, z = 7},
	{x = 32952, y = 32270, z = 7},
	{x = 32951, y = 32270, z = 7},
	{x = 32953, y = 32264, z = 7},
	{x = 32383, y = 32852, z = 6},
	{x = 32393, y = 32838, z = 0},
	{x = 32393, y = 32839, z = 0},
	{x = 32393, y = 32840, z = 0},
	{x = 32572, y = 31875, z = 10},
	{x = 32571, y = 31875, z = 10},
	{x = 32724, y = 31975, z = 6},
	{x = 32801, y = 31861, z = 6},
	{x = 32800, y = 31862, z = 6},
	{x = 32801, y = 31862, z = 6},
	{x = 32801, y = 31863, z = 6},
	{x = 32800, y = 31863, z = 6},
	{x = 33227, y = 32389, z = 5},
	{x = 33228, y = 32389, z = 5},
	{x = 33329, y = 32171, z = 5},
	{x = 33330, y = 32171, z = 5},
	{x = 33305, y = 31991, z = 6},
	{x = 33305, y = 31992, z = 6},
	{x = 33311, y = 31990, z = 6},
	{x = 33312, y = 31990, z = 6},
	{x = 33361, y = 32048, z = 7},
	{x = 33363, y = 32047, z = 7},
	{x = 33364, y = 32045, z = 7},
	{x = 33359, y = 32046, z = 7},
	{x = 33331, y = 32056, z = 7},
	{x = 33332, y = 32055, z = 7},
	{x = 33335, y = 32054, z = 7},
	{x = 33334, y = 32049, z = 7},
	{x = 33313, y = 31946, z = 7},
	{x = 33314, y = 31882, z = 7},
	{x = 33280, y = 31842, z = 8},
	{x = 33226, y = 32869, z = 7},
	{x = 33204, y = 31909, z = 7},
	{x = 33218, y = 31924, z = 7},
	{x = 33220, y = 31924, z = 7}
}

local fakePlayerOutfits = {
    [1] = {136, 137, 138, 139, 140, 141, 142, 147, 148, 149, 150}, -- female outfits
    [2] = {128, 129, 130, 131, 132, 133, 134, 143, 144, 145, 146} -- male outfits
}

local fakePlayerRunes = {
    [1] = { id = 3189, count = 3},
    [2] = { id = 3152, count = 1},
	[3] = { id = 3198, count = 5}
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
		
		player:addManaSpent(2500)
		if player:getLevel() <= 17 then
			if player:getVocation():getId() == 2 then
				player:addExperience(math.random(2500, 11000), false)
			else
				player:addExperience(math.random(9000, 11000), false)
			end
		end
		
		if player:getItemCount(3578) <= 0 then
			local randomFakePlayerPosition = math.random(1, #fakePlayers)
			player:teleportTo(fakePlayers[randomFakePlayerPosition])
			Game.sendMagicEffect(fakePlayers[randomFakePlayerPosition], 11)
			table.remove(fakePlayers, randomFakePlayerPosition)
			
			local container = Game.createItem(2854, 1)
			container:addItem(3578, math.random(5, 15))
			if math.random(5, 15) >= 10 then
				container:addItem(3483, 1)
			end
			if math.random(5, 15) >= 5 then
				container:addItem(3003, 1)
			end
			
			player:addItemEx(container, true, CONST_SLOT_BACKPACK)
			
			if player:getVocation():getId() == 1 or player:getVocation():getId() == 2 or player:getVocation():getId() == 3 then
				local backpackCount = math.random(1, 2)
				local runeCount = math.random(5, 20) * backpackCount
				for i=1,backpackCount do
					local bp = Game.createItem(2854, 1)
					for i=1,20 do
						if runeCount <= 0 then
							bp:addItem(3147, 1)
						else
							bp:addItem(fakePlayerRunes[player:getVocation():getId()].id, fakePlayerRunes[player:getVocation():getId()].count)
							runeCount = runeCount - 1
						end
					end
					
					player:addItemEx(bp, true, CONST_SLOT_BACKPACK)
				end
			end
		end
		
		if player:getStorageValue(17740) ~= 1 then
			local fakeOutfitTypes = fakePlayerOutfits[player:getSex() + 1]
			player:setOutfit({
				lookType = fakeOutfitTypes[math.random(#fakeOutfitTypes)],
				lookHead = math.random(0, 132),
				lookBody = math.random(0, 132),
				lookLegs = math.random(0, 132),
				lookFeet = math.random(0, 132)
			})
			player:setStorageValue(17740, 1)
		end
	end
	
	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("kills")
	player:registerEvent("PlayerLogout")
	player:registerEvent("FirstItems")
	player:registerEvent("RegenerateStamina")
	
	return true
end
