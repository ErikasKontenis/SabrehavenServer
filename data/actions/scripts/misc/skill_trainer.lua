local statues = {
	[17725] = SKILL_SWORD,
	[17724] = SKILL_AXE,
	[17726] = SKILL_CLUB,
	[17727] = SKILL_DISTANCE,
	[17728] = SKILL_MAGLEVEL
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- local skill = statues[item:getActionId()]
	-- if not player:isPremium() then
		-- player:sendCancelMessage(RETURNVALUE_YOUNEEDPREMIUMACCOUNT)
		-- return true
	-- end

	-- if player:isPzLocked() then
		-- return false
	-- end
	
	-- local entreePrice = 1000
	-- if player:getBankBalance() < entreePrice then
		-- player:sendCancelMessage("You do not have 1000 gold coins in your bank account balance to participate in offline training.")
		-- return true
	-- end
	
	-- player:setOfflineTrainingSkill(skill)
	-- player:setBankBalance(player:getBankBalance() - entreePrice)
	-- player:remove()
	return true
end
