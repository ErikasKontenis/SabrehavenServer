local doorPosition = Position(32260, 32791, 7)
local shadowNexusPosition = Position(33115, 31702, 12)
local effectPositions = {
	Position(33113, 31702, 12),
	Position(33116, 31702, 12)
}

local function revertItem(position, itemId, transformId)
	local item = Tile(position):getItemById(itemId)
	if item then
		item:transform(transformId)
	end
end

local function nexusMessage(player, message)
	local spectators = Game.getSpectators(shadowNexusPosition, false, true, 3, 3)
	for i = 1, #spectators do
		player:say(message, TALKTYPE_MONSTER_YELL, false, spectators[i], shadowNexusPosition)
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Eclipse
	if target.actionid == 2000 then
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		-- The Inquisition Questlog- 'Mission 2: Eclipse'
		player:setStorageValue(12162, 2)
		player:setStorageValue(12160, 5)
		return true

	-- Haunted Ruin
	elseif target.actionid == 2003 then
		if player:getStorageValue(12160) ~= 12 then
			return true
		end

		Game.createMonster('Pirate Ghost', toPosition)
		item:remove(1)

		-- The Inquisition Questlog- 'Mission 4: The Haunted Ruin'
		player:setStorageValue(12160, 13)
		player:setStorageValue(12164, 2)

		local doorItem = Tile(doorPosition):getItemById(8697)
		if doorItem then
			doorItem:transform(8696)
		end
		addEvent(revertItem, 10 * 1000, doorPosition, 8696, 8697)
		return true
	end

	-- Shadow Nexus
	if isInArray({8753, 8755, 8757}, target.itemid) then
		target:transform(target.itemid + 1)
		target:decay()
		nexusMessage(player, player:getName() .. ' damaged the shadow nexus! You can\'t damage it while it\'s burning.')
		shadowNexusPosition:sendMagicEffect(CONST_ME_HOLYAREA)

	elseif target.itemid == 8759 then
		if player:getStorageValue(12160) < 22 then
			-- The Inquisition Questlog- 'Mission 7: The Shadow Nexus'
			player:setStorageValue(12167, 2)
			player:setStorageValue(12160, 22)
		end

		for i = 1, #effectPositions do
			effectPositions[i]:sendMagicEffect(CONST_ME_HOLYAREA)
		end

		nexusMessage(player, player:getName() .. ' destroyed the shadow nexus! In 20 seconds it will return to its original state.')
		item:remove(1)
	end
	return true
end