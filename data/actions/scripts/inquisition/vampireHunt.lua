local altars = {
	Position(32778, 31977, 9),
	Position(32776, 31982, 9),
	Position(32780, 31982, 9)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(12160) == 8 then
		player:setStorageValue(12160, 9)
		player:setStorageValue(12163, 4) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
		local k = {}
		for i = 1, #altars do
			local tmp = Tile(altars[i]):getItemById(3083)
			if not tmp then
				Game.createMonster("The Count", toPosition)
				return true
			else
				k[#k + 1] = tmp
			end
		end
		for i = 1, #k do
			k[i]:remove()
		end
		Game.createMonster("The Weakened Count", toPosition)
		return true
	end
end