function onLogin(player)
	if player:getStorageValue(17571) ~= 1 and not player:isFakePlayer() then
		player:setStorageValue(17571, 1)
		
		-- Items
		player:addItem(3355, 1, true, -1, CONST_SLOT_HEAD)
		player:addItem(3361, 1, true, -1, CONST_SLOT_ARMOR)
		player:addItem(3559, 1, true, -1, CONST_SLOT_LEGS)
		player:addItem(3552, 1, true, -1, CONST_SLOT_FEET)
		player:addItem(3412, 1, true, -1, CONST_SLOT_LEFT)
		player:addItem(3007, 1, true, 100, CONST_SLOT_RING)
		player:addItem(2920, 1, true, -1, CONST_SLOT_AMMO)
		
		if player:getVocation():getId() == 1 then
			player:addItem(3074, 1, true, -1, CONST_SLOT_RIGHT)
		elseif player:getVocation():getId() == 2 then
			player:addItem(3066, 1, true, -1, CONST_SLOT_RIGHT)
		elseif player:getVocation():getId() == 3 then
			player:addItem(3277, 1, true, 5, CONST_SLOT_RIGHT)
		elseif player:getVocation():getId() == 4 then
			local weapons = { 3300, 3286, 3276 }
			player:addItem(weapons[math.random(#weapons)], 1, true, -1, CONST_SLOT_RIGHT)
		end
		
		local container = Game.createItem(2854, 1)
		container:addItem(3585, 1)
		container:addItem(3031, 25)
		container:addItem(3725, 5)
		container:addItem(3003, 1)
		container:addItem(3457, 1)
		
		player:addItemEx(container, true, CONST_SLOT_BACKPACK)
	
		-- Default Outfit
		if player:getSex() == PLAYERSEX_FEMALE then
			player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
		else
			player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
		end
	end
	return true
end
