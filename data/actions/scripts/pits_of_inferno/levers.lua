local text = {
	[1] = 'first', [2] = 'second', [3] = 'third', [4] = 'fourth', [5] = 'fifth',
	[6] = 'sixth', [7] = 'seventh', [8] = 'eighth', [9] = 'ninth', [10] = 'tenth',
	[11] = 'eleventh', [12] = 'twelfth', [13] = 'thirteenth', [14] = 'fourteenth', [15] = 'fifteenth'
}

local stonePositions = {
	Position(32851, 32333, 12),
	Position(32852, 32333, 12)
}

local function createStones()
	for i = 1, #stonePositions do
		Game.createItem(1791, 1, stonePositions[i])
	end

	setGlobalStorageValue(17657, 0)
end

local function revertLever(position)
	local leverItem = Tile(position):getItemById(2773)
	if leverItem then
		leverItem:transform(2772)
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= 2772 then
		return false
	end

	local leverCount = math.max(0, getGlobalStorageValue(17657))
	if item:getActionId() > 2049 and item:getActionId() < 2065 then
		local number = item:getActionId() - 2049
		if leverCount + 1 ~= number then
			return false
		end

		setGlobalStorageValue(17657, number)
		player:say('You flipped the ' .. text[number] .. ' lever. Hurry up and find the next one!', TALKTYPE_MONSTER_SAY, false, player, toPosition)
	elseif item:getActionId() == 2065 then
		if leverCount ~= 15 then
			player:say('The final lever won\'t budge... yet.', TALKTYPE_MONSTER_SAY)
			return true
		end

		local stone
		for i = 1, #stonePositions do
			stone = Tile(stonePositions[i]):getItemById(1791)
			if stone then
				stone:remove()
				stonePositions[i]:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
			end
		end

		addEvent(createStones, 15 * 60 * 1000)
	end

	item:transform(2773)
	addEvent(revertLever, 15 * 60 * 1000, toPosition)
	return true
end
