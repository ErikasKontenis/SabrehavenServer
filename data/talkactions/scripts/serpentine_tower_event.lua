local area = {
    fromPos = {x = 33140, y = 32859, z = 7},
    toPos = {x = 33155, y = 32874, z = 4}
}

local availablePlayerTeleportPositions = {
	Position(33139, 32859, 7),
	Position(33139, 32860, 7),
	Position(33139, 32861, 7),
	Position(33139, 32862, 7),
	Position(33139, 32863, 7),
	Position(33139, 32864, 7),
	Position(33139, 32865, 7),
	Position(33139, 32866, 7),
	Position(33139, 32867, 7),
	Position(33139, 32868, 7),
	Position(33139, 32869, 7),
	Position(33139, 32870, 7),
	Position(33139, 32871, 7),
	Position(33139, 32872, 7),
	Position(33139, 32873, 7),
	Position(33139, 32874, 7),
	Position(33139, 32875, 7),
	Position(33140, 32875, 7),
	Position(33143, 32875, 7),
	Position(33144, 32875, 7),
	Position(33146, 32875, 7),
	Position(33148, 32875, 7),
	Position(33149, 32875, 7),
	Position(33150, 32875, 7),
	Position(33155, 32875, 7),
	Position(33156, 32875, 7),
	Position(33156, 32874, 7),
	Position(33156, 32873, 7),
	Position(33156, 32872, 7),
	Position(33156, 32871, 7),
	Position(33156, 32870, 7),
	Position(33156, 32869, 7),
	Position(33156, 32868, 7),
	Position(33156, 32867, 7),
	Position(33156, 32866, 7),
	Position(33156, 32865, 7),
	Position(33156, 32864, 7),
	Position(33156, 32863, 7),
	Position(33156, 32862, 7),
	Position(33156, 32861, 7),
	Position(33156, 32860, 7),
	Position(33156, 32859, 7),
	Position(33156, 32858, 7)
}

local downstairsIds = {451, 466, 465, 467}

local earthquakeEffects = {CONST_ME_POFF, CONST_ME_EXPLOSIONHIT, CONST_ME_EXPLOSIONAREA, CONST_ME_FIREAREA, CONST_ME_ENERGYHIT, CONST_ME_BLOCKHIT}

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	teleportPlayersToSerpentineTower()
	addEvent(wave1, 20000)
	addEvent(wave2, 40000)
	addEvent(wave3, 100000)
	addEvent(wave4, 160000)
	addEvent(wave5, 170000)
	addEvent(wave6, 175000)
	addEvent(wave7, 180000)
	addEvent(wave8, 195000)
	addEvent(wave9, 205000)
	
	return false
end

function teleportPlayersToSerpentineTower()
	for _, player in ipairs(Game.getPlayers()) do
		player:setStorageValue(17596, 1)
		local teleportPosition = availablePlayerTeleportPositions[math.random(#availablePlayerTeleportPositions)]
		player:teleportTo(teleportPosition)
		player:getPosition():sendMonsterSay("accersi " .. player:getName())
	end
end

function wave1()
	broadcastMessage("LOOK AT MY EYES! ... THE EYES! ... LET ME OUT! ...", MESSAGE_STATUS_WARNING)
	earthquakeTower(area.fromPos, area.toPos)
end

function wave2()
	broadcastMessage("Ankrahmun: The Academy of Magic Arts are reporting that Ankrahmun city is experiencing issues! Please stay safe in the protection zones, NOW!", MESSAGE_STATUS_WARNING)
	earthquakeTower(area.fromPos, area.toPos)
end

function wave3()
	broadcastMessage("Ankrahmun: All Tibianus PEOPLE. THIS IS NOT A PRACTICE. Leave our city NOW!", MESSAGE_STATUS_WARNING)
	earthquakeTower(area.fromPos, area.toPos)
end

function wave4()
	broadcastMessage("THE EYES ARE EVERYWHERE!", MESSAGE_STATUS_WARNING)
	earthquakeTower(area.fromPos, area.toPos)
end

function wave5()
	Position(33149, 32868, 7):sendMonsterSay("accersi Tothdral")
	local tothdral = Creature("Tothdral")
	tothdral:teleportTo(Position(33149, 32867, 7))
	tothdral:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

function wave6()
	Position(33147, 32870, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33151, 32870, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33151, 32866, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33147, 32866, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	
	local tile = Tile(Position(33149, 32868, 7))
	if tile then
		local obelisk = tile:getItemById(2199)
		if obelisk ~= nil then
			obelisk:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			obelisk:remove()
			local hole = Game.createItem(5731, 1, tile:getPosition())
			hole:setAttribute(ITEM_ATTRIBUTE_MOVEMENTID, 17596)
		end
	end
end

function wave7()
	Position(33147, 32870, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33151, 32870, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33151, 32866, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33147, 32866, 7):sendMonsterSay("The Serpentine Tower Secret Is Real!")
	Position(33149, 32868, 7):sendMonsterSay("LET ME OUT!")
end

function wave8()
	broadcastMessage("Ankrahmun: WE ARE LOST FOREVER!", MESSAGE_STATUS_WARNING)
	for xx = area.fromPos.x, area.toPos.x do
		for yy = area.fromPos.y, area.toPos.y do
			local position = Position(xx, yy, 7)
			local tile = Tile(position)
			if tile then
				local ground = tile:getGround()
				if ground ~= nil and ground:getId() == 231 then
					ground:transform(2144)
				end
			end
		end
	end
	
	Game.createItem(2199, 1, Position(33140, 32859, 7))
	Position(33140, 32859, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33140, 32874, 7))
	Position(33140, 32874, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33155, 32874, 7))
	Position(33155, 32874, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33155, 32859, 7))
	Position(33155, 32859, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33149, 32863, 7))
	Position(33149, 32863, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33153, 32866, 7))
	Position(33153, 32866, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33153, 32871, 7))
	Position(33153, 32871, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33149, 32873, 7))
	Position(33149, 32873, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33145, 32871, 7))
	Position(33145, 32871, 7):sendMagicEffect(CONST_ME_TELEPORT)
	Game.createItem(2199, 1, Position(33145, 32866, 7))
	Position(33145, 32866, 7):sendMagicEffect(CONST_ME_TELEPORT)
end

function wave9()
	broadcastMessage("Ankrahmun: PROTEGO MAXIMA!", MESSAGE_STATUS_WARNING)
	
	for _, player in ipairs(Game.getPlayers()) do
		player:teleportTo(player:getTown():getTemplePosition())
	end
end

function earthquakeTower(frompos, topos)
	for zz = frompos.z, topos.z, -1 do
		if zz == 6 then
			topos.x = topos.x + 1
			topos.y = topos.y + 1
		end

		for xx = frompos.x, topos.x do
			for yy = frompos.y, topos.y do
				local position = Position(xx, yy, zz)
				removeFloorItems(position)
				copyHigherFloorItems(position)
			end
        end
		
		if zz == 6 then
			topos.x = topos.x - 1
			topos.y = topos.y - 1
		end
    end
end

function removeFloorItems(position)
	local tile = Tile(position)
	if tile then
		-- If any creature is in area then teleport it to safe zone to properly work with tile items
		local creature = tile:getTopCreature()
		if creature then
			local teleportPosition = availablePlayerTeleportPositions[math.random(#availablePlayerTeleportPositions)]
			creature:teleportTo(teleportPosition)
			creature:getPosition():sendMonsterSay("The Gods Protecting You!")
			Game.sendMagicEffect(teleportPosition, 11)
			if creature:isPlayer() then
				if creature:getStorageValue(17596) ~= 2 then
					creature:setStorageValue(17596, 2)
				end
			end
		end
		
		local currentFloorItem = tile:getItemByType(0)
		while currentFloorItem ~= nil do
			currentFloorItem:remove()
			currentFloorItem = tile:getItemByType(0)
		end
		
		local items = tile:getItems()
		if items ~= nil then
			for _, item in pairs(items) do
				item:remove()
			end
		end
		
		-- Create sand floor only for ground level
		if position.z == 7 then
			Game.createTile(position)
			Game.createItem(231, 1, position)
		end
	end
end

function copyHigherFloorItems(position)
	local higherFloorPosition = {x = position.x, y = position.y, z = position.z - 1}
	local tile = Tile(higherFloorPosition)
	if tile then
		local higherFloorItem = tile:getItemByType(0)
		while(higherFloorItem ~= nil) do
			if position.z ~= 7 or isInArray(downstairsIds, higherFloorItem:getId()) == false then
				Game.createItem(higherFloorItem:getId(), 1, position)
			end
			
			higherFloorItem:remove()
			higherFloorItem = tile:getItemByType(0)
		end
		
		local items = tile:getItems()
		if items ~= nil then
			for _, item in pairs(items) do
				if position.z ~= 7 or isInArray(downstairsIds, item:getId()) == false then
					Game.createItem(item:getId(), 1, position)
				end
				
				item:remove()
			end
		end
		
		local effectRandomness = math.random(5)
		if effectRandomness == 5 then
			local earthquakeEffect = earthquakeEffects[math.random(#earthquakeEffects)]
			tile:getPosition():sendMagicEffect(earthquakeEffect)
		end
	end
end

-- TODO: Implement that bitch npc is busy and says that I don't understand what is happening. The Academy of Magic Arts are not commenting the current situation.