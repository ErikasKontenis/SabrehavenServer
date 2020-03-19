local area = {
    fromPos = {x = 33144, y = 32863, z = 7},
    toPos = {x = 33154, y = 32873, z = 7}
}

function onSay(player, words, param)
	if player:getPosition():isInRange(area.fromPos, area.toPos) then
		local tile1 = Tile(Position(33147, 32868, 7))
		if tile1 then
			local stoneRailing = tile1:getItemById(2212)
			if stoneRailing ~= nil then
				stoneRailing:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				stoneRailing:remove()
				broadcastMessage("The player " .. player:getName() .. " have opened The Serpentine Tower!", MESSAGE_STATUS_WARNING)
			end
		end
		
		local tile2 = Tile(Position(33149, 32866, 7))
		if tile2 then
			local stoneRailing = tile2:getItemById(2210)
			if stoneRailing ~= nil then
				stoneRailing:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				stoneRailing:remove()
			end
		end
		
		local tile3 = Tile(Position(33151, 32868, 7))
		if tile3 then
			local stoneRailing = tile3:getItemById(2211)
			if stoneRailing ~= nil then
				stoneRailing:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				stoneRailing:remove()
			end
		end
		
		local tile4 = Tile(Position(33149, 32870, 7))
		if tile4 then
			local stoneRailing = tile4:getItemById(2209)
			if stoneRailing ~= nil then
				stoneRailing:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				stoneRailing:remove()
			end
		end
	end
	
	return true
end