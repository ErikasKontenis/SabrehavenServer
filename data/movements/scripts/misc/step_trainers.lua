local trainingRoomExit = {x = 32231, y = 32200, z = 7}

function checkTrainingTile(playerId, pos, movementId)
	local player = Player(playerId)
	if not player then
		return true
	end
   
	if getTopCreature(pos).uid ~= playerId then
		return true
	end
   
	if player:getStorageValue(17709) >= 10800000 then
		player:teleportTo(trainingRoomExit)
		Position(pos):sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your training time have expired. Come back tomorrow.")
		Position(player:getPosition()):sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
   
	local trainingTime = player:getStorageValue(17709)
	player:setStorageValue(17709, trainingTime + 60000)
	player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have " .. math.modf((10800000 - trainingTime) / 1000 / 60) .. " minutes of remaining training time in the Thais training chamber.")
	addEvent(checkTrainingTile, 60000, playerId, pos, movementId)
	return true
end

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local dayOfYear = tonumber(os.date("%j"))

	-- Reset counting storage value if it does not match the last time saved day
	if player:getStorageValue(17711) ~= dayOfYear then
		player:setStorageValue(17709, 0)
	end
	
	if player:getStorageValue(17711) == dayOfYear and player:getStorageValue(17709) >= 10800000 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not allowed to train today anymore. Come back tomorrow.")
		if position == fromPosition then
			player:teleportTo(trainingRoomExit)
		else
			player:teleportTo(fromPosition)
		end
		return true
	end
	
	if player:getStorageValue(17710) > os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 1 minute training monk chamber step in timeout.")
		if position == fromPosition then
			player:teleportTo(trainingRoomExit)
		else
			player:teleportTo(fromPosition)
		end
		return true
	end
	
	local playerId = player:getId()
	local pos = player:getPosition()
	
	local trainingTime = player:getStorageValue(17709)
	player:setStorageValue(17709, trainingTime + 60000)
	player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have " .. math.modf((10800000 - trainingTime) / 1000 / 60) .. " minutes of remaining training time in the Thais training chamber.")
	player:setStorageValue(17710, os.time() + 1 * 60)
	player:setStorageValue(17711, dayOfYear)
	addEvent(checkTrainingTile, 60000, playerId, pos, item:getMovementId())
end