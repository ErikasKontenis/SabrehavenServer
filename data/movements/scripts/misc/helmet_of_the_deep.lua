function onEquip(player, item, slot)
    player:removeCondition(CONDITION_DROWN)
	return true
end