local fruits = {3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3595, 3596, 5096}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArray(fruits, target.itemid) and player:removeItem(2874, 1, 0) then
		target:remove(1)
		player:addItem(2874, target.itemid == 3589 and 14 or 15)
		return true
	end
end