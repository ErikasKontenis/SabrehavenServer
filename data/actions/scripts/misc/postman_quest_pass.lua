function onUse(player, item, fromPosition, target, toPosition)
	if player:getStorageValue(250) == 5 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already finished The Postman Missions.")
		return true
	end
	
	player:setStorageValue(227, 6)
	player:setStorageValue(228, 3)
	player:setStorageValue(229, 4)
	player:setStorageValue(230, 21)
	player:setStorageValue(231, 3)
	player:setStorageValue(233, 11)
	player:setStorageValue(234, 8)
	player:setStorageValue(242, 2)
	player:setStorageValue(244, 3)
	player:setStorageValue(245, 3)
	player:setStorageValue(250, 5)
	
	item:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
	item:remove()
	return true
end
