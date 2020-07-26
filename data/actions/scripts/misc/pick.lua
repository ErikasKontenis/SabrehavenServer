local pitsOfInfernoLava = {
	Position(32808, 32336, 11),
	Position(32809, 32336, 11),
	Position(32810, 32336, 11),
	Position(32808, 32334, 11),
	Position(32807, 32334, 11),
	Position(32807, 32335, 11),
	Position(32807, 32336, 11),
	Position(32807, 32337, 11),
	Position(32806, 32337, 11),
	Position(32805, 32337, 11),
	Position(32805, 32338, 11),
	Position(32805, 32339, 11),
	Position(32806, 32339, 11),
	Position(32806, 32338, 11),
	Position(32807, 32338, 11),
	Position(32808, 32338, 11),
	Position(32808, 32337, 11),
	Position(32809, 32337, 11),
	Position(32810, 32337, 11),
	Position(32811, 32337, 11),
	Position(32811, 32338, 11),
	Position(32806, 32338, 11),
	Position(32810, 32338, 11),
	Position(32810, 32339, 11),
	Position(32809, 32339, 11),
	Position(32809, 32338, 11),
	Position(32811, 32336, 11),
	Position(32811, 32335, 11),
	Position(32810, 32335, 11),
	Position(32809, 32335, 11),
	Position(32808, 32335, 11),
	Position(32809, 32334, 11),
	Position(32809, 32333, 11),
	Position(32810, 32333, 11),
	Position(32811, 32333, 11),
	Position(32806, 32338, 11),
	Position(32810, 32334, 11),
	Position(32811, 32334, 11),
	Position(32812, 32334, 11),
	Position(32813, 32334, 11),
	Position(32812, 32333, 11),
	Position(32810, 32334, 11),
	Position(32812, 32335, 11),
	Position(32813, 32335, 11),
	Position(32813, 32333, 11)
}
		
function onUse(player, item, fromPosition, target, toPosition)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end
	
	if ground:getId() == 372 then
		ground:transform(394, 1)
		ground:decay()
		return true
	elseif target:getId() == 1772 and toPosition.x == 32648 and toPosition.y == 32134 and toPosition.z == 10 and math.random(1, 100) <= 40 then 
		Game.sendMagicEffect({x = 32648, y = 32134, z = 10}, 3)
		Game.removeItemOnMap({x = 32648, y = 32134, z = 10}, 1772)
		return true
	elseif target:getId() == 1772 and toPosition.x == 32648 and toPosition.y == 32134 and toPosition.z == 10 then 
		Game.sendMagicEffect({x = 32648, y = 32134, z = 10}, 3)
		doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -40, -40)
		return true
	elseif target:getId() == 1791 and toPosition.x == 32356 and toPosition.y == 32074 and toPosition.z == 10 and math.random(1, 100) <= 40 then 
		Game.sendMagicEffect({x = 32356, y = 32074, z = 10}, 3)
		Game.removeItemOnMap({x = 32356, y = 32074, z = 10}, 1791)
		return true
	elseif target:getId() == 1791 and toPosition.x == 32356 and toPosition.y == 32074 and toPosition.z == 10 then
		Game.sendMagicEffect({x = 32356, y = 32074, z = 10}, 3)
		doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -50, -50)
		return true
	elseif target:getActionId() == 17643 then
		for i = 1, #pitsOfInfernoLava do
			Game.createItem(5815, 1, pitsOfInfernoLava[i])
		end
		target:transform(3141)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end
	return false
end
