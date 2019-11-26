function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPosition = player:getPosition()
	local afrompos = {x=playerPosition.x - 1, y=playerPosition.y - 1, z=playerPosition.z}
	local atopos = {x=playerPosition.x + 1, y=playerPosition.y + 1, z=playerPosition.z}
	for xa = afrompos.x,atopos.x do
		for ya = afrompos.y,atopos.y do
			for za = afrompos.z,atopos.z do
				local npos = {x = xa,y = ya,z = za}	
				local depotItem = Tile(npos):getItemByType(ITEM_TYPE_DEPOT)
				if depotItem ~= nil then
					player:sendCancelMessage("You cannot use this object.")
					return true
				end
			end
		end
	end
	
	local dicePosition = item:getPosition()
	local value = math.random(6)
	local isInGhostMode = player:isInGhostMode()

	dicePosition:sendMagicEffect(CONST_ME_CRAPS, isInGhostMode and player)

	local spectators = Game.getSpectators(dicePosition, false, true, 3, 3)
	for i = 1, #spectators do
		player:say(player:getName() .. " rolled a " .. value .. ".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], dicePosition)
	end

	item:transform(5791 + value)
	return true
end
