function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local arenaId = item:getMovementId() - 23200
	if arenaId >= creature:getStorageValue(1100) then
		return true
	end

	local cStorage = ARENA[arenaId].reward.trophyStorage
	if creature:getStorageValue(cStorage) ~= 1 then
		local rewardPosition = creature:getPosition()
		rewardPosition.y = rewardPosition.y - 1

		local rewardItem = Game.createItem(ARENA[arenaId].reward.trophy, 1, rewardPosition)
		if rewardItem then
			rewardItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format(ARENA[arenaId].reward.desc, creature:getName()))
		end

		creature:setStorageValue(cStorage, 1)
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	end
	return true
end