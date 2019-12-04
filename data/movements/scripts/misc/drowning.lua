local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_HIT_DAMAGE, 20)
condition:setTiming(9999)


function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player == nil then
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
