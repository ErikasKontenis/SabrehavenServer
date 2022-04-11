function Game.sendMagicEffect(position, effect)
	local pos = Position(position)
	pos:sendMagicEffect(effect)
end

function Game.removeItemsOnMap(position)
	local tile = Tile(position)
	local tileCount = tile:getThingCount()
	local i = 0
	while i < tileCount do
		local tileItem = tile:getThing(i)
		if tileItem and tileItem:getType():isMovable() then
			tileItem:remove()
		else
			i = i + 1
		end
	end
end

function Game.transformItemOnMap(position, itemId, toItemId, subtype)
	if not subtype then
		subtype = -1
	end

	local tile = Tile(position)
	local item = tile:getItemById(itemId)
	item:transform(toItemId, subtype)
	item:decay()
	return item
end

function Game.removeItemOnMap(position, itemId, subtype)
	if not subtype then
		subtype = -1
	end
	
	local tile = Tile(position)
	local item = tile:getItemById(itemId, subtype)
	item:remove()
end

function Game.isItemThere(position, itemId)
	local tile = Tile(position)
	return tile:getItemById(itemId) ~= nil
end

function Game.isPlayerThere(position)
	local tile = Tile(position)
	local creatures = tile:getCreatures()
	for _, creature in ipairs(creatures) do
		if creature:isPlayer() then
			return true
		end
	end
	return false
end

function Game.isMonsterThere(position, monsterName)
	local tile = Tile(position)
	local creatures = tile:getCreatures()
	for _, creature in ipairs(creatures) do
		if creature:isMonster() and creature:getName():lower() == monsterName:lower() then
			return creature
		end
	end
	return nil
end

function Game.broadcastMessage(message, messageType)
	if messageType == nil then
		messageType = MESSAGE_STATUS_WARNING
	end

	for _, player in ipairs(Game.getPlayers()) do
		player:sendTextMessage(messageType, message)
	end
end

function Game.convertIpToString(ip)
	local band = bit.band
	local rshift = bit.rshift
	return string.format("%d.%d.%d.%d",
		band(ip, 0xFF),
		band(rshift(ip, 8), 0xFF),
		band(rshift(ip, 16), 0xFF),
		rshift(ip, 24)
	)
end

function Game.getReverseDirection(direction)
	if direction == WEST then
		return EAST
	elseif direction == EAST then
		return WEST
	elseif direction == NORTH then
		return SOUTH
	elseif direction == SOUTH then
		return NORTH
	elseif direction == NORTHWEST then
		return SOUTHEAST
	elseif direction == NORTHEAST then
		return SOUTHWEST
	elseif direction == SOUTHWEST then
		return NORTHEAST
	elseif direction == SOUTHEAST then
		return NORTHWEST
	end
	return NORTH
end

function Game.getSkillType(weaponType)
	if weaponType == WEAPON_CLUB then
		return SKILL_CLUB
	elseif weaponType == WEAPON_SWORD then
		return SKILL_SWORD
	elseif weaponType == WEAPON_AXE then
		return SKILL_AXE
	elseif weaponType == WEAPON_DISTANCE then
		return SKILL_DISTANCE
	elseif weaponType == WEAPON_SHIELD then
		return SKILL_SHIELD
	end
	return SKILL_FIST
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	-- Return from local table if possible
    if globalStorageTable[key] ~= nil then
        return globalStorageTable[key]
    end

    -- Else look for it on the DB
    local dbData = db.storeQuery("SELECT `value` FROM `global_storage` WHERE `key` = " .. key .. " LIMIT 1;")
    if dbData ~= false then
        local value = result.getNumber(dbData, "value")
        if value ~= nil then
            -- Save it to globalStorageTable
            globalStorageTable[key] = value
            return value
        end
    end

    return nil
end

function Game.setStorageValue(key, value)
	globalStorageTable[key] = value

    local dbData = db.storeQuery("SELECT `value` FROM `global_storage` WHERE `key` = " .. key .. " LIMIT 1;")
    if dbData ~= false then
        db.query("UPDATE `global_storage` SET `value`='".. value .."' WHERE `key` = " .. key .. " LIMIT 1;")
    else
        db.query("INSERT INTO `global_storage` (`key`, `value`) VALUES (" .. key .. ", " .. value .. ");")
    end
end

do
	local cdShort = {"d", "h", "m", "s"}
	local cdLong = {" day", " hour", " minute", " second"}
	local function getTimeUnitGrammar(amount, unitID, isLong)
		return isLong and string.format("%s%s", cdLong[unitID], amount ~= 1 and "s" or "") or cdShort[unitID]
	end

	function Game.getCountdownString(duration, longVersion, hideZero)
		if duration < 0 then
			return "expired"
		end

		local days = math.floor(duration / 86400)
		local hours = math.floor((duration % 86400) / 3600)
		local minutes = math.floor((duration % 3600) / 60)
		local seconds = math.floor(duration % 60)

		local response = {}
		if hideZero then
			if days > 0 then
				response[#response + 1] = days .. getTimeUnitGrammar(days, 1, longVersion)
			end

			if hours > 0 then
				response[#response + 1] = hours .. getTimeUnitGrammar(hours, 2, longVersion)
			end

			if minutes > 0 then
				response[#response + 1] = minutes .. getTimeUnitGrammar(minutes, 3, longVersion)
			end

			if seconds > 0 then
				response[#response + 1] = seconds .. getTimeUnitGrammar(seconds, 4, longVersion)
			end
		else
			if days > 0 then
				response[#response + 1] = days .. getTimeUnitGrammar(days, 1, longVersion)
				response[#response + 1] = hours .. getTimeUnitGrammar(hours, 2, longVersion)
				response[#response + 1] = minutes .. getTimeUnitGrammar(minutes, 3, longVersion)
				response[#response + 1] = seconds .. getTimeUnitGrammar(seconds, 4, longVersion)
			elseif hours > 0 then
				response[#response + 1] = hours .. getTimeUnitGrammar(hours, 2, longVersion)
				response[#response + 1] = minutes .. getTimeUnitGrammar(minutes, 3, longVersion)
				response[#response + 1] = seconds .. getTimeUnitGrammar(seconds, 4, longVersion)
			elseif minutes > 0 then
				response[#response + 1] = minutes .. getTimeUnitGrammar(minutes, 3, longVersion)
				response[#response + 1] = seconds .. getTimeUnitGrammar(seconds, 4, longVersion)
			elseif seconds >= 0 then
				response[#response + 1] = seconds .. getTimeUnitGrammar(seconds, 4, longVersion)
			end
		end

		return table.concat(response, " ")
	end
end
