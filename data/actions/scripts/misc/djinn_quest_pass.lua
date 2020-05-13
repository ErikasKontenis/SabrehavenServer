local greenDjinnItem = 6549
local blueDjinnItem = 6551

function onUse(player, item, fromPosition, target, toPosition)
	if player:getStorageValue(278) > 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already finished one of the djinn quest or your quest is in-progress.")
		return true
	end
	
	if item:getId() == greenDjinnItem then
		player:setStorageValue(278, 3)
		player:setStorageValue(286, 3)
		player:setStorageValue(287, 3)
		player:setStorageValue(288, 3)
	elseif item:getId() == blueDjinnItem then
		player:setStorageValue(278, 2)
		player:setStorageValue(280, 2)
		player:setStorageValue(281, 2)
		player:setStorageValue(282, 2)
		player:setStorageValue(283, 3)
	end
	
	item:getPosition():sendMagicEffect(3)
	item:remove()
	return true
end
