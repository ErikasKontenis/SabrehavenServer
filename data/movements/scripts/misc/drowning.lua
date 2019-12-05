local condition = Condition(CONDITION_DROWN)
condition:setTiming(5)


function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player == nil then
		return true
	end
	
	local helmet = player:getSlotItem(CONST_SLOT_HEAD)
	if helmet ~= nil and helmet:getId() == 5460 then
		return true
	end
	
	if math.random(1, 10) == 1 then
		position:sendMagicEffect(CONST_ME_BUBBLES)
	end
	player:addCondition(condition)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player == nil then
		return true
	end

	player:removeCondition(CONDITION_DROWN)
	return true
end
