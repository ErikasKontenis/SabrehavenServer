local config = {
	[17653] = { doorPosition = {x = 32833, y = 32333, z = 11}, vocationIds = {4, 8} },
	[17656] = { doorPosition = {x = 32835, y = 32333, z = 11}, vocationIds = {1, 5} },
	[17655] = { doorPosition = {x = 32831, y = 32333, z = 11}, vocationIds = {3, 7} },
	[17654] = { doorPosition = {x = 32837, y = 32333, z = 11}, vocationIds = {2, 6} }
}

local function doTransformDoors(position)
	local tile = Tile(Position(position))
	if tile then
		local lockedDoor = tile:getItemById(1628)
		local closedDoor = tile:getItemById(1629)
		local openDoor = tile:getItemById(1630)
		if lockedDoor then
			lockedDoor:transform(1629, 1)
			lockedDoor:decay()
		elseif closedDoor then
			closedDoor:transform(1628, 1)
			closedDoor:decay()
		elseif openDoor then
			openDoor:transform(1628, 1)
			openDoor:decay()
		end
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local configValue = config[item:getActionId()];
	if isInArray(configValue.vocationIds, player:getVocation():getId()) then
		doTransformDoors(configValue.doorPosition)
		Position(configValue.doorPosition):sendMagicEffect(CONST_ME_FIREAREA)
		item:transform(item.itemid == 2772 and 2773 or 2772)
		return true
	end
	
	return false
end
