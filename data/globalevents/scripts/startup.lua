local monsterOfTheDay = {
	{ id = 8430, monster = 'Crocodile' },
	{ id = 8431, monster = 'Tarantula' },
	{ id = 8432, monster = 'Carniphila' },
	{ id = 8433, monster = 'Merlkin' },
	{ id = 8434, monster = 'Kongra' },
	{ id = 8435, monster = 'Sibang' },
	{ id = 8436, monster = 'Thornback Tortoise' },
	{ id = 8437, monster = 'Gargoyle' },
	{ id = 8438, monster = 'Quara Constrictor Scout' },
	{ id = 8439, monster = 'Quara Hydromancer Scout' },
	{ id = 8440, monster = 'Quara Mantassin Scout' },
	{ id = 8441, monster = 'Quara Pincher Scout' },
	{ id = 8442, monster = 'Quara Predator Scout' },
	{ id = 8443, monster = 'Ancient Scarab' },
	{ id = 8444, monster = 'Wyvern' },
	{ id = 8445, monster = 'Bonebeast' },
	{ id = 8446, monster = 'Dragon' },
	{ id = 8447, monster = 'Quara Constrictor' },
	{ id = 8448, monster = 'Quara Hydromancer' },
	{ id = 8449, monster = 'Quara Mantassin' },
	{ id = 8450, monster = 'Quara Pincher' },
	{ id = 8451, monster = 'Quara Predator' },
	{ id = 8452, monster = 'Giant Spider' },
	{ id = 8453, monster = 'Banshee' },
	{ id = 8454, monster = 'Lich' },
	{ id = 8455, monster = 'Acolyte of The Cult' },
	{ id = 8456, monster = 'Adept of The Cult' },
	{ id = 8457, monster = 'Enlightened of The Cult' },
	{ id = 8458, monster = 'Novice of The Cult' },
	{ id = 8459, monster = 'Hydra' },
	{ id = 8460, monster = 'Serpent Spawn' },
	{ id = 8461, monster = 'Behemoth' },
	{ id = 8462, monster = 'Dragon Lord' },
	{ id = 8463, monster = 'Hand of Cursed Fate' },
	{ id = 8464, monster = 'Juggernaut' },
	{ id = 8465, monster = 'Frost Troll' },
	{ id = 8466, monster = 'Swamp Troll' },
	{ id = 8467, monster = 'Rat' },
	{ id = 8468, monster = 'Cave Rat' },
	{ id = 8469, monster = 'Wolf' },
	{ id = 8470, monster = 'Winter Wolf' },
	{ id = 8471, monster = 'Wasp' },
	{ id = 8472, monster = 'Larva' },
	{ id = 8473, monster = 'Dwarf' },
	{ id = 8474, monster = 'Skeleton' },
	{ id = 8475, monster = 'Ghoul' },
	{ id = 8476, monster = 'Elf' },
	{ id = 8477, monster = 'Elf Scout' },
	{ id = 8478, monster = 'Elf Arcanist' },
	{ id = 8479, monster = 'Bug' },
	{ id = 8480, monster = 'Smuggler' },
	{ id = 8481, monster = 'Wild Warrior' },
	{ id = 8482, monster = 'Bandit' },
	{ id = 8483, monster = 'Hyaena' },
	{ id = 8484, monster = 'Lion' },
	{ id = 8485, monster = 'Bear' },
	{ id = 8486, monster = 'Slime' },
	{ id = 8487, monster = 'Beholder' },
	{ id = 8488, monster = 'Elder Beholder' },
	{ id = 8489, monster = 'Green Djinn' },
	{ id = 8490, monster = 'Blue Djinn' },
	{ id = 8491, monster = 'Marid' },
	{ id = 8492, monster = 'Efreet' },
	{ id = 8493, monster = 'Pirate Skeleton' },
	{ id = 8494, monster = 'Pirate Marauder' },
	{ id = 8495, monster = 'Pirate Cutthroat' },
	{ id = 8496, monster = 'Pirate Ghost' },
	{ id = 8497, monster = 'Pirate Buccaneer' },
	{ id = 8498, monster = 'Pirate Corsair' },
	{ id = 8499, monster = 'Orc Spearman' },
	{ id = 8500, monster = 'Orc Shaman' },
	{ id = 8501, monster = 'Orc Rider' },
	{ id = 8502, monster = 'Orc Warrior' },
	{ id = 8503, monster = 'Orc Berserker' },
	{ id = 8504, monster = 'Minotaur Archer' },
	{ id = 8505, monster = 'Minotaur Guard' },
	{ id = 8506, monster = 'Minotaur Mage' },
	{ id = 8507, monster = 'Lizard Templar' },
	{ id = 8508, monster = 'Lizard Sentinel' },
	{ id = 8509, monster = 'Lizard Snakecharmer' },
	{ id = 8510, monster = 'Dwarf Soldier' },
	{ id = 8511, monster = 'Dwarf Guard' },
	{ id = 8512, monster = 'Dwarf Geomancer' },
	{ id = 8513, monster = 'Ghost' },
	{ id = 8514, monster = 'Demon Skeleton' },
	{ id = 8515, monster = 'Vampire' },
	{ id = 8516, monster = 'Orc Leader' },
	{ id = 8517, monster = 'Orc Warlord' },
	{ id = 8518, monster = 'Hero' },
	{ id = 8519, monster = 'Necromancer' },
	{ id = 8520, monster = 'Priestess' },
	{ id = 8521, monster = 'Nightmare' },
	{ id = 8522, monster = 'Warlock' },
	{ id = 8523, monster = 'Demon' },
	{ id = 8524, monster = 'Troll' },
	{ id = 8525, monster = 'Goblin' },
	{ id = 8526, monster = 'Rotworm' },
	{ id = 8527, monster = 'Carrion Worm' },
	{ id = 8528, monster = 'Cyclops' },
	{ id = 8529, monster = 'Amazon' },
	{ id = 8530, monster = 'Minotaur' },
	{ id = 8531, monster = 'Orc' }
}

local function spawnRashid()
	local rashidSpawns = {
		['Monday'] = Position(32349, 32231, 6),
		['Tuesday'] = Position(32306, 32835, 7),
		['Wednesday'] = Position(32579, 32754, 7),
		['Thursday'] = Position(33065, 32879, 6),
		['Friday'] = Position(33233, 32484, 7),
		['Saturday'] = Position(33168, 31810, 6),
		['Sunday'] = Position(32328, 31782, 6),
	}
	
	local position = rashidSpawns[os.date("%A")]
	local rashid = Game.createNpc("rashid", position)
	if rashid ~= nil then
		rashid:setMasterPos(position)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	end
end

local function setBloomingGriffinclaw()
	local position = {x = 32024, y = 32830, z = 4}
    if Game.isItemThere(position,5687) then
		Game.removeItemOnMap(position, 5687)
		Game.createItem(5658, 1, position)
		Game.sendMagicEffect(position, 15)
	end
end

function onStartup()
	math.randomseed(os.mtime())
	
	db.query("TRUNCATE TABLE `players_online`")
	db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getDataInt(resultId, "account_id")
			db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getDataString(resultId, "reason")) .. ", " .. result.getDataLong(resultId, "banned_at") .. ", " .. result.getDataLong(resultId, "expires_at") .. ", " .. result.getDataInt(resultId, "banned_by") .. ")")
			db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Check house auctions
	local resultId = db.storeQuery("SELECT `id`, `highest_bidder`, `last_bid`, (SELECT `balance` FROM `players` WHERE `players`.`id` = `highest_bidder`) AS `balance` FROM `houses` WHERE `owner` = 0 AND `bid_end` != 0 AND `bid_end` < " .. os.time())
	if resultId ~= false then
		repeat
			local house = House(result.getDataInt(resultId, "id"))
			if house ~= nil then
				local highestBidder = result.getDataInt(resultId, "highest_bidder")
				local balance = result.getDataLong(resultId, "balance")
				local lastBid = result.getDataInt(resultId, "last_bid")
				if balance >= lastBid then
					db.query("UPDATE `players` SET `balance` = " .. (balance - lastBid) .. " WHERE `id` = " .. highestBidder)
					house:setOwnerGuid(highestBidder)
				end
				db.asyncQuery("UPDATE `houses` SET `last_bid` = 0, `bid_end` = 0, `highest_bidder` = 0, `bid` = 0 WHERE `id` = " .. house:getId())
			end
		until not result.next(resultId)
		result.free(resultId)
	end
	
	-- Remove murders that are more than 60 days old
	local resultId = db.storeQuery("SELECT * FROM `player_murders` WHERE `date` <= " .. os.time() - 60 * 24 * 60 * 60)
	if resultId ~= false then
		repeat
			local playerId = result.getDataInt(resultId, "player_id")
			local id = result.getDataLong(resultId, "id")
			
			db.asyncQuery("DELETE FROM `player_murders` WHERE `player_id` = " .. playerId .. " AND `id` = " .. id)
		until not result.next(resultId)
		result.free(resultId)
	end
	
	-- blooming griffinclaw
	local dayNow = tonumber(os.date("%d", os.time()))
	if (dayNow == 1) then
		setGlobalStorageValue(1, 0)
	end
	
	if getGlobalStorageValue(1) == 0 then
		local randomDay = math.random(dayNow, 28)
		if (randomDay == 28) then
			setGlobalStorageValue(1, 1)
			addEvent(setBloomingGriffinclaw, 10000)
		end
	end
	
	spawnRashid()
	--addEvent(function () Game.setGameState(GAME_STATE_CLOSED) end, 5000)
	setGlobalStorageValue(17657, 0) -- reset POI levers
	setGlobalStorageValue(8420, monsterOfTheDay[math.random(1, #monsterOfTheDay)].id)
	setGlobalStorageValue(8421, math.random(10, 25))
end
