local config = {
	[3031] = {changeTo = 3035},
	[3035] = {changeBack = 3031, changeTo = 3043},
	[3043] = {changeBack = 3035}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local ring = player:getSlotItem(CONST_SLOT_RING)
	if ring == nil or ring:getId() ~= 3007 then
		return false
	end
	
	local ringCharges = ring:getAttribute(ITEM_ATTRIBUTE_CHARGES)
	local coin = config[item:getId()]
	if coin.changeTo and item.type == 100 then
		item:remove()
		player:addItem(coin.changeTo, 1)
		if ringCharges > 1 then
			ring:setAttribute(ITEM_ATTRIBUTE_CHARGES,(ringCharges-1))
		else
			ring:remove(1)
		end
	elseif coin.changeBack then
		item:remove(1)
		player:addItem(coin.changeBack, 100)
		if ringCharges > 1 then
			ring:setAttribute(ITEM_ATTRIBUTE_CHARGES,(ringCharges-1))
		else
			ring:remove(1)
		end
	else
		return false
	end
	return true
end