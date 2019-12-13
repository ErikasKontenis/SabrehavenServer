local maps = {
	[17528] = "You have successfully read plan A.",
	[17529] = "You have successfully read plan B.",
	[17530] = "You have successfully read plan C."
}

function onUse(player, item, fromPosition, target, toPosition)
	local mapActionId = item:getActionId()
	local map = maps[mapActionId]
	if not map then
		return false
	end
	
	local playerPosition = player:getPosition()
	if player:getStorageValue(17520) < 8 then
		player:say("You shouldn't touch these maps because someone might see you.", TALKTYPE_MONSTER_SAY, false, 0, playerPosition)
		return true
	end
	
	if player:getStorageValue(mapActionId) ~= 1 then
		player:say(map, TALKTYPE_MONSTER_SAY, false, 0, playerPosition)
		player:setStorageValue(mapActionId, 1)
	else
		player:say("You have already read this map.", TALKTYPE_MONSTER_SAY, false, 0, playerPosition)
	end
	
	return true
end
