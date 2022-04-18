function onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	if targetMonster:getName():lower() ~= 'ungreez' then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(12160) == 18 then
		-- The Inquisition Questlog- 'Mission 6: The Demon Ungreez'
		player:setStorageValue(12166, 2)
		player:setStorageValue(12160, 19)
	end
	return true
end