local pos = { Position(32861, 32305, 11), Position(32860, 32313, 11) }

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() ~= 2772 then
		return false
	end

	item:transform(2773)

	if item:getActionId() == 3301 then
		local lava = Tile(pos[1]):getItemById(727)
		if lava then
			lava:transform(1771)
		end

		local dirtId, dirtItem = { 4797, 4799 }
		for i = 1, #dirtId do
			dirtItem = Tile(pos[1]):getItemById(dirtId[i])
			if dirtItem then
				dirtItem:remove()
			end
		end
	elseif item:getActionId() == 3302 then
		local item = Tile(pos[2]):getItemById(389)
		if item then
			item:remove()
		end
	end
	return true
end