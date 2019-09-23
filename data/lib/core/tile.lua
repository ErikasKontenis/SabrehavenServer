function Tile.isItem(self)
	return false
end

function Tile.isContainer(self)
	return false
end

function Tile.isCreature(self)
	return false
end

function Tile.isPlayer(self)
	return false
end

function Tile.isTeleport(self)
	return false
end

function Tile.isTile(self)
	return true
end

function Tile.relocateTo(self, toPosition, pushMove, monsterPosition)
	if self:getPosition() == toPosition then
		return false
	end

	if not Tile(toPosition) then
		return false
	end

	for i = self:getThingCount() - 1, 0, -1 do
		local thing = self:getThing(i)
		if thing then
			if thing:isItem() then
				if ItemType(thing.itemid):isMovable() then
					thing:moveTo(toPosition)
				end
			elseif thing:isCreature() then
				if monsterPosition and thing:isMonster() then
					thing:teleportTo(monsterPosition, pushMove)
				else
					thing:teleportTo(toPosition, pushMove)
				end
			end
		end
	end
	return true
end

function Tile:getPlayers()
	local players = {}
	local creatures = self:getCreatures()
	if (creatures) then
		for i = 1, #creatures do 
			if (creatures[i]:isPlayer()) then 
				table.insert(players, creatures[i])
			end
		end
	end

	return players
end