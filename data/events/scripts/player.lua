local monsterOfTheDay = {
	[8430] = { monster = 'Crocodile' },
	[8431] = { monster = 'Tarantula' },
	[8432] = { monster = 'Carniphila' },
	[8433] = { monster = 'Merlkin' },
	[8434] = { monster = 'Kongra' },
	[8435] = { monster = 'Sibang' },
	[8436] = { monster = 'Thornback Tortoise' },
	[8437] = { monster = 'Gargoyle' },
	[8438] = { monster = 'Quara Constrictor Scout' },
	[8439] = { monster = 'Quara Hydromancer Scout' },
	[8440] = { monster = 'Quara Mantassin Scout' },
	[8441] = { monster = 'Quara Pincher Scout' },
	[8442] = { monster = 'Quara Predator Scout' },
	[8443] = { monster = 'Ancient Scarab' },
	[8444] = { monster = 'Wyvern' },
	[8445] = { monster = 'Bonebeast' },
	[8446] = { monster = 'Dragon' },
	[8447] = { monster = 'Quara Constrictor' },
	[8448] = { monster = 'Quara Hydromancer' },
	[8449] = { monster = 'Quara Mantassin' },
	[8450] = { monster = 'Quara Pincher' },
	[8451] = { monster = 'Quara Predator' },
	[8452] = { monster = 'Giant Spider' },
	[8453] = { monster = 'Banshee' },
	[8454] = { monster = 'Lich' },
	[8455] = { monster = 'Acolyte of The Cult' },
	[8456] = { monster = 'Adept of The Cult' },
	[8457] = { monster = 'Enlightened of The Cult' },
	[8458] = { monster = 'Novice of The Cult' },
	[8459] = { monster = 'Hydra' },
	[8460] = { monster = 'Serpent Spawn' },
	[8461] = { monster = 'Behemoth' },
	[8462] = { monster = 'Dragon Lord' },
	[8463] = { monster = 'Hand of Cursed Fate' },
	[8464] = { monster = 'Juggernaut' },
	[8465] = { monster = 'Frost Troll' },
	[8466] = { monster = 'Swamp Troll' },
	[8467] = { monster = 'Rat' },
	[8468] = { monster = 'Cave Rat' },
	[8469] = { monster = 'Wolf' },
	[8470] = { monster = 'Winter Wolf' },
	[8471] = { monster = 'Wasp' },
	[8472] = { monster = 'Larva' },
	[8473] = { monster = 'Dwarf' },
	[8474] = { monster = 'Skeleton' },
	[8475] = { monster = 'Ghoul' },
	[8476] = { monster = 'Elf' },
	[8477] = { monster = 'Elf Scout' },
	[8478] = { monster = 'Elf Arcanist' },
	[8479] = { monster = 'Bug' },
	[8480] = { monster = 'Smuggler' },
	[8481] = { monster = 'Wild Warrior' },
	[8482] = { monster = 'Bandit' },
	[8483] = { monster = 'Hyaena' },
	[8484] = { monster = 'Lion' },
	[8485] = { monster = 'Bear' },
	[8486] = { monster = 'Slime' },
	[8487] = { monster = 'Beholder' },
	[8488] = { monster = 'Elder Beholder' },
	[8489] = { monster = 'Green Djinn' },
	[8490] = { monster = 'Blue Djinn' },
	[8491] = { monster = 'Marid' },
	[8492] = { monster = 'Efreet' },
	[8493] = { monster = 'Pirate Skeleton' },
	[8494] = { monster = 'Pirate Marauder' },
	[8495] = { monster = 'Pirate Cutthroat' },
	[8496] = { monster = 'Pirate Ghost' },
	[8497] = { monster = 'Pirate Buccaneer' },
	[8498] = { monster = 'Pirate Corsair' },
	[8499] = { monster = 'Orc Spearman' },
	[8500] = { monster = 'Orc Shaman' },
	[8501] = { monster = 'Orc Rider' },
	[8502] = { monster = 'Orc Warrior' },
	[8503] = { monster = 'Orc Berserker' },
	[8504] = { monster = 'Minotaur Archer' },
	[8505] = { monster = 'Minotaur Guard' },
	[8506] = { monster = 'Minotaur Mage' },
	[8507] = { monster = 'Lizard Templar' },
	[8508] = { monster = 'Lizard Sentinel' },
	[8509] = { monster = 'Lizard Snakecharmer' },
	[8510] = { monster = 'Dwarf Soldier' },
	[8511] = { monster = 'Dwarf Guard' },
	[8512] = { monster = 'Dwarf Geomancer' },
	[8513] = { monster = 'Ghost' },
	[8514] = { monster = 'Demon Skeleton' },
	[8515] = { monster = 'Vampire' },
	[8516] = { monster = 'Orc Leader' },
	[8517] = { monster = 'Orc Warlord' },
	[8518] = { monster = 'Hero' },
	[8519] = { monster = 'Necromancer' },
	[8520] = { monster = 'Priestess' },
	[8521] = { monster = 'Nightmare' },
	[8522] = { monster = 'Warlock' },
	[8523] = { monster = 'Demon' },
	[8524] = { monster = 'Troll' },
	[8525] = { monster = 'Goblin' },
	[8526] = { monster = 'Rotworm' },
	[8527] = { monster = 'Carrion Worm' },
	[8528] = { monster = 'Cyclops' },
	[8529] = { monster = 'Amazon' },
	[8530] = { monster = 'Minotaur' },
	[8531] = { monster = 'Orc' }
}

local trainingStatues = {17724, 17725, 17726, 17727, 17728}

function Player:onLook(thing, position, distance)
	local description = "You see " .. thing:getDescription(distance)
	
	if thing:isItem() and thing:getId() == 2028 then
		if isInArray(trainingStatues, thing:getActionId()) then
			local trainingTime = math.min(43200 / 2, self:getOfflineTrainingTime() / 1000)
			local text = "You have"
			local hours = math.floor(trainingTime / 3600)
			if hours > 1 then
				text = string.format("%s %d hours", text, hours)
			elseif hours == 1 then
				text = string.format("%s 1 hour", text)
			end

			local minutes = math.floor((trainingTime % 3600) / 60)
			if minutes ~= 0 then
				if hours ~= 0 then
					text = string.format("%s and", text)
				end

				if minutes > 1 then
					text = string.format("%s %d minutes", text, minutes)
				else
					text = string.format("%s 1 minute", text)
				end
			end

			text = string.format(" %s offline training time remaining.", text)
			
			description = string.format(description .. "%s", text)
		end
	end
			
	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_MOVEMENTID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format("%s, Movement ID: %d", description, uniqueId)
			end

			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end
			if thing:getAttribute(ITEM_ATTRIBUTE_DECAYSTATE) == 1 then
				description = string.format("%s\nDecaying in %d minutes (%d seconds).", description, thing:getAttribute(ITEM_ATTRIBUTE_DURATION) / 1000 / 60, thing:getAttribute(ITEM_ATTRIBUTE_DURATION) / 1000)
			end
		elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:isPlayer() and thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end

		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if thing:isCreature() then
			if thing:isPlayer() then
				local client = thing:getClient()
				description = string.format("%s\nIP: %s PING: %i FPS: %i.", description, Game.convertIpToString(thing:getIp()), client.ping, client.fps)
			end
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			local client = thing:getClient()
			description = string.format("%s\nIP: %s PING: %i FPS: %i.", description, Game.convertIpToString(thing:getIp()), client.ping, client.fps)
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, "You see " .. item:getDescription(distance))
end


local showAtkWeaponTypes = {WEAPON_CLUB, WEAPON_SWORD, WEAPON_AXE, WEAPON_DISTANCE}
local showDefWeaponTypes = {WEAPON_CLUB, WEAPON_SWORD, WEAPON_AXE, WEAPON_DISTANCE, WEAPON_SHIELD}
function Player:onLookInMarket(itemType)
	local response = NetworkMessage()
	response:addByte(0xF8)
	response:addU16(itemType:getId())
	
	-- armor
	do
		local armor = itemType:getArmor()
		if armor > 0 then
			response:addString(armor)
		else
			response:addU16(0)
		end
	end

	-- weapon data (will be reused)
	local weaponType = itemType:getWeaponType()

	-- attack
	do
		local showAtk = table.contains(showAtkWeaponTypes, weaponType)
		if showAtk then
			local atkAttrs = {}
			local atk = itemType:getAttack()
			if itemType:isBow() then
				if atk ~= 0 then
					atkAttrs[#atkAttrs + 1] = string.format("%+d", atk)
				end

				local hitChance = itemType:getHitChance()
				if hitChance ~= 0 then
					atkAttrs[#atkAttrs + 1] = string.format("chance to hit %+d%%", hitChance)
				end

				atkAttrs[#atkAttrs + 1] = string.format("%d fields", itemType:getShootRange())
			else
				atkAttrs[#atkAttrs + 1] = atk
				local elementDmg = 0
				if elementDmg ~= 0 then
					atkAttrs[#atkAttrs] = string.format("%d physical %+d %s", atkAttrs[#atkAttrs], elementDmg, getCombatName(itemType:getElementType()))
				end
			end

			response:addString(table.concat(atkAttrs, ", "))
		else
			response:addU16(0)
		end
	end

	-- container slots
	do
		if itemType:isContainer() then
			response:addString(itemType:getCapacity())
		else
			response:addU16(0)
		end
	end

	-- defense
	do
		local showDef = table.contains(showDefWeaponTypes, weaponType)
		if showDef then
			local def = itemType:getDefense()
			if weaponType == WEAPON_DISTANCE then
				-- throwables
				if ammoType ~= AMMO_ARROW and ammoType ~= AMMO_BOLT then
					response:addString(def)
				else
					response:addU16(0)
				end
			else
				-- extra def
				--local xD = itemType:getExtraDefense()
				--if xD ~= 0 then
				--	def = string.format("%d %+d", def, xD)
				--end

				response:addString(def)
			end
		else
			response:addU16(0)
		end
	end

	-- description
	do
		local desc = itemType:getDescription()
		if desc and #desc > 0 then
			response:addString(desc)
		else
			response:addU16(0)
		end
	end

	-- duration
	do
		local duration = itemType:getDuration()
		if duration == 0 then
			local transferType = itemType:getTransformEquipId()
			if transferType ~= 0 then
				transferType = ItemType(transferType)
				duration = transferType and transferType:getDuration() or duration
			end
		end

		if duration > 0 then
			response:addString(Game.getCountdownString(duration, true, true))
		else
			response:addU16(0)
		end
	end

	-- item abilities (will be reused)
	local abilities = itemType:getAbilities()

	-- element protections
	do
		local protections = {}
		for element, value in pairs(abilities.absorbPercent) do
			if value ~= 0 then
				protections[#protections + 1] = string.format("%s %+d%%", getCombatName(2 ^ (element - 1)), value)
			end
		end

		if #protections > 0 then
			response:addString(table.concat(protections, ", "))
		else
			response:addU16(0)
		end
	end

	-- level req
	do
		local minLevel = itemType:getMinReqLevel()
		if minLevel > 0 then
			response:addString(minLevel)
		else
			response:addU16(0)
		end
	end

	-- magic level req
	do
		local minMagicLevel = itemType:getMinReqMagicLevel()
		if minMagicLevel > 0 then
			response:addString(minMagicLevel)
		else
			response:addU16(0)
		end
	end

	-- vocation
	do
		local vocations = itemType:getVocationString()
		if vocations and vocations:len() > 0 then
			response:addString(vocations)
		else
			response:addU16(0)
		end
	end

	-- rune words
	do
		local spellName = itemType:getRuneSpellName()
		if spellName and spellName:len() > 0 then
			response:addString(spellName)
		else
			response:addU16(0)
		end
	end

	-- "skill boost" category
	do
		-- skill boost
		local skillBoosts = {}
		if abilities.manaGain > 0 or abilities.healthGain > 0 or abilities.regeneration then
			skillBoosts[#skillBoosts + 1] = "faster regeneration"
		end

		-- invisibility
		if abilities.invisible then
			skillBoosts[#skillBoosts + 1] = "invisibility"
		end

		-- magic shield (classic)
		if abilities.manaShield then
			skillBoosts[#skillBoosts + 1] = "magic shield"
		end

		-- stats (hp/mp/soul/ml)
		for stat, value in pairs(abilities.stats) do
			if value ~= 0 then
				skillBoosts[#skillBoosts + 1] = string.format("%s %+d", getStatName(stat - 1), value)
			end
		end

		-- stats but in %
		for stat, value in pairs(abilities.statsPercent) do
			if value ~= 0 then
				skillBoosts[#skillBoosts + 1] = string.format("%s %+d%%", getStatName(stat - 1), value)
			end
		end

		-- speed
		if abilities.speed ~= 0 then
			skillBoosts[#skillBoosts + 1] = string.format("speed %+d", abilities.speed)
		end

		-- skills
		for skill, value in pairs(abilities.skills) do
			if value ~= 0 then
				skillBoosts[#skillBoosts + 1] = string.format("%s %+d", getSkillName(skill - 1), value)
			end
		end

		-- add to response
		if #skillBoosts > 0 then
			response:addString(table.concat(skillBoosts, ", "))
		else
			response:addU16(0)
		end
	end

	-- charges
	do
		if itemType:hasShowCharges() then
			response:addString(itemType:getCharges())
		else
			response:addU16(0)
		end
	end

	-- weapon type
	do
		if itemType:isWeapon() then
			response:addString(itemType:getWeaponString())
		else
			response:addU16(0)
		end
	end

	-- weight
	response:addString(string.format("%0.2f", itemType:getWeight() / 100))
	
	-- buy stats
	do
		local stats = itemType:getMarketBuyStatistics()
		if stats then
			response:addByte(0x01)
			response:addU32(stats.numTransactions)
			response:addU64(stats.totalPrice)
			response:addU64(stats.highestPrice)
			response:addU64(stats.lowestPrice)
		else
			response:addByte(0x00)
		end
	end

	-- sell stats
	do
		local stats = itemType:getMarketSellStatistics()
		if stats then
			response:addByte(0x01)
			response:addU32(stats.numTransactions)
			response:addU64(stats.totalPrice)
			response:addU64(stats.highestPrice)
			response:addU64(stats.lowestPrice)
		else
			response:addByte(0x00)
		end
	end

	response:sendToPlayer(self)
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	return true
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	return true
end

function Player:onReportBug(message, position, category)
	if self:getAccountType() == ACCOUNT_TYPE_NORMAL then
		return false
	end

	local name = self:getName()
	local file = io.open("data/reports/bugs/" .. name .. " report.txt", "a")

	if not file then
		self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "There was an error when processing your report, please contact a gamemaster.")
		return true
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Name: " .. name)
	if category == BUG_CATEGORY_MAP then
		io.write(" [Map position: " .. position.x .. ", " .. position.y .. ", " .. position.z .. "]")
	end
	local playerPosition = self:getPosition()
	io.write(" [Player Position: " .. playerPosition.x .. ", " .. playerPosition.y .. ", " .. playerPosition.z .. "]\n")
	io.write("Comment: " .. message .. "\n")
	io.close(file)

	self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Your report has been sent to " .. configManager.getString(configKeys.SERVER_NAME) .. ".")
	return true
end

function Player:onTurn(direction)
	return true
end

function Player:onTradeRequest(target, item)
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	return true
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

function Player:onGainExperience(source, exp, rawExp)
	if not source or source:isPlayer() then
		return exp
	end
	
	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	-- Apply experience stage multiplier
	if (vocation:getId() > 0 or self:getLevel() < 8) then
		exp = exp * Game.getExperienceStage(self:getLevel())
	end
	
	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		if self:getStorageValue(17582) > os.time() then
			exp = exp * 1.1
		end
		
		local staminaMinutes = self:getStamina()
		if staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end
	
	if getGlobalStorageValue(17589) > os.time() then
		exp = exp * (1 + getGlobalStorageValue(17585) / 100) 
	end
	
	if source:isMonster() and not source:getMaster() then
		if getGlobalStorageValue(8420) > 0 then
			if source:getName():lower() == monsterOfTheDay[getGlobalStorageValue(8420)].monster:lower() then
				exp = exp * (1 + getGlobalStorageValue(8421) / 100)
			end
		end
	end
	
	if self:isPremium() then
		exp = exp * (1 + 10 / 100) 
	end
	
	return exp
end

function Player:onLoseExperience(exp)
	return exp
end

function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	if skill == SKILL_MAGLEVEL then
		tries = tries * configManager.getNumber(configKeys.RATE_MAGIC)
		
		if getGlobalStorageValue(17591) > os.time() then
			tries = tries * (1 + getGlobalStorageValue(17587) / 100) 
		end
		
		return tries
	end
	
	tries = tries * configManager.getNumber(configKeys.RATE_SKILL)
	
	if getGlobalStorageValue(17590) > os.time() then
		tries = tries * (1 + getGlobalStorageValue(17586) / 100) 
	end
	
	return tries
end
