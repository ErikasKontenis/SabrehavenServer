function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	if target:getId() == 2917 then
		player:addItem(5813, 1)
		item:remove(1)
		target:remove(1)
		return true
	end
		
	return false
end
