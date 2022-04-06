local weaponSkillsConfig = {
	[WEAPON_SWORD] = SKILL_SWORD,
	[WEAPON_CLUB] = SKILL_CLUB,
	[WEAPON_AXE] = SKILL_AXE,
	[WEAPON_DISTANCE] = SKILL_DISTANCE
}

local skillNameConfig = {
	[SKILL_SWORD] = "Sword Fighting",
	[SKILL_CLUB] = "Club Fighting",
	[SKILL_AXE] = "Axe Fighting",
	[SKILL_DISTANCE] = "Distance Fighting",
	[SKILL_FIST] = "Fist Fighting"
}

local function ltrim(s)
	if s == nil then
		return s
	end
	
	return s:match'^%s*(.*)'
end

local function getWeapon(player)
	local itemLeft = player:getSlotItem(CONST_SLOT_LEFT)
	if itemLeft and itemLeft:getType():getWeaponType() ~= WEAPON_NONE and itemLeft:getType():getWeaponType() ~= WEAPON_SHIELD and itemLeft:getType():getWeaponType() ~= WEAPON_AMMO and itemLeft:getType():getWeaponType() ~= WEAPON_WAND then
		return itemLeft:getType()
	end
	
	local itemRight = player:getSlotItem(CONST_SLOT_RIGHT)
	if itemRight and itemRight:getType():getWeaponType() ~= WEAPON_NONE and itemRight:getType():getWeaponType() ~= WEAPON_SHIELD and itemRight:getType():getWeaponType() ~= WEAPON_AMMO and itemRight:getType():getWeaponType() ~= WEAPON_WAND then
		return itemRight:getType()
	end
end

local function getAmmunition(player)
	local item = player:getSlotItem(CONST_SLOT_AMMO)
	if item and item:getType():getWeaponType() == WEAPON_AMMO then
		return item:getType()
	end
end

local function getAttack(weapon, ammunition)
	local attack = 7
	if weapon ~= nil then
		attack = weapon:getAttack()
		if weapon:getWeaponType() == WEAPON_DISTANCE and weapon:getAmmoType() ~= 0 then
			if ammunition ~= nil and ammunition:getAmmoType() == weapon:getAmmoType() then
				attack = attack + ammunition:getAttack()
			end
		end
	end
	
	return attack
end

local function getDamageFormula(attack, attackSkill, fightMode)
	local damage = attack
	if fightMode == FIGHTMODE_ATTACK then
		damage = math.floor(damage + 2 * damage / 10)
	elseif fightMode == FIGHTMODE_DEFENSE then
		damage = math.floor(damage - 4 * damage / 10)
	end

	local formula = math.floor((5 * (attackSkill) + 50) * damage)
	return formula
end

local function getDamage(attack, attackSkill, fightMode, random1, random2)	
	local formula = getDamageFormula(attack, attackSkill, fightMode)
	local randResult = math.floor(random1 % 100);
	local damage = -math.floor((math.ceil(formula * ((random2 % 100 + randResult) / 2) / 10000.)));
	return damage
end

local function setVocationDamageIncrease(vocationId, damage)
	if vocationId == 4 or vocationId == 8 then
		local knightCloseAttackDamageIncreasePercent = configManager.getNumber(configKeys.KNIGHT_CLOSE_ATTACK_DAMAGE_INCREASE_PERCENT)
		if knightCloseAttackDamageIncreasePercent ~= -1 then
			damage = math.floor(damage + damage * knightCloseAttackDamageIncreasePercent / 100);
		end
	elseif vocationId == 3 or vocationId == 7 then
		local paladinRangeAttackDamageIncreasePercent = configManager.getNumber(configKeys.PALADIN_RANGE_ATTACK_DAMAGE_INCREASE_PERCENT)
		if paladinRangeAttackDamageIncreasePercent ~= -1 then
			damage = math.floor(damage + damage * paladinRangeAttackDamageIncreasePercent / 100);
		end
	end
	
	return damage
end

local function getDefense(creature, random1, random2)
	local totalDefense = creature:getType():getDefense() + 1
	local defenseSkill = creature:getType():getSkill()
	local formula = math.floor((5 * (defenseSkill) + 50) * totalDefense)
	local randresult = math.floor(random1 % 100)

	return math.floor(formula * ((random2 % 100 + randresult) / 2) / 10000.)
end

local function rshift(x, by)
  return math.floor(x / 2 ^ by)
end

local function getArmor(creature, rand)
	local armor = creature:getType():getArmor()
	if armor > 1 then
		return rand % rshift(armor, 1) + rshift(armor, 1);
	end
	
	return armor
end

local function setPhysicalDamageBlock(creature, isCloseRange, damage, random1, random2, randomArmor)
	if bit.band(creature:getType():getCombatImmunities(), COMBAT_PHYSICALDAMAGE) == COMBAT_PHYSICALDAMAGE then
		return 0
	end
	
	if isCloseRange then
		damage = damage + getDefense(creature, random1, random2)
	end
	
	if damage >= 0 then
		return 0
	end
	
	if damage < 0 then
		damage = damage + getArmor(creature, randomArmor)
		if damage >= 0 then
			return 0
		end
	end

	return damage
end

local function isThrowableHit(weapon, ammunition, skillValue, rand)
	local distance = 75 -- we consider distance is always the best
	local hitChance = 75 -- throwables and such

	if weapon:getAmmoType() ~= 0 then
		hitChance = 90 -- bows and crossbows
		if ammunition == nil or ammunition:getAmmoType() ~= weapon:getAmmoType() then
			hitChance = -1 -- no ammo or invalid ammo
		end
	end
	
	if rand % distance <= skillValue then
		return rand % 100 <= hitChance
	end
	
	return false
end

local function getTotalDamage(creature, weapon, ammunition, vocation, attack, skillValue, fightMode)
	local damage = setVocationDamageIncrease(vocation:getId(), getDamage(attack, skillValue, fightMode, os.rand(), os.rand()))
	local minDamage = setVocationDamageIncrease(vocation:getId(), getDamage(attack, skillValue, fightMode, 0, 0))
	local maxDamage = setVocationDamageIncrease(vocation:getId(), getDamage(attack, skillValue, fightMode, 99, 99))
	
	if weapon ~= nil and weapon:getWeaponType() == WEAPON_DISTANCE then
		if isThrowableHit(weapon, ammunition, skillValue, os.rand()) then
			damage = setPhysicalDamageBlock(creature, false, damage, os.rand(), os.rand(), os.rand())
		else
			damage = 0
		end
		minDamage = 0
		if isThrowableHit(weapon, ammunition, skillValue, 0) then
			maxDamage = setPhysicalDamageBlock(creature, false, maxDamage, 0, 0, 0)
		else
			maxDamage = 0
		end
	else
		damage = setPhysicalDamageBlock(creature, true, damage, os.rand(), os.rand(), os.rand())
		minDamage = setPhysicalDamageBlock(creature, true, minDamage, 99, 99, rshift(creature:getType():getArmor(), 1) + 1)
		maxDamage = setPhysicalDamageBlock(creature, true, maxDamage, 0, 0, 0)
	end
	
	local container = {}
	container[0] = damage
	container[1] = minDamage
	container[2] = maxDamage
	return container
end

function onSay(player, words, param)
	local split = param:split(",")
	local creatureName = ltrim(split[1])
	local skillValueNumber = ltrim(split[2])
	local vocationName = ltrim(split[3])
	local weaponName = ltrim(split[4])
	local ammunitionName = ltrim(split[5])

	local creature = Creature("Troll")
	if creatureName ~= nil then
		creature = Creature(creatureName)
		if creature == nil then
			player:sendCancelMessage("The monster does not exist.")
			return false
		end
	else
		creatureName = creature:getName()
	end
	
	local weapon = getWeapon(player)
	if weaponName ~= nil then
		weapon = ItemType(weaponName)
		if weapon == nil or weapon:getWeaponType() == WEAPON_NONE or weapon:getWeaponType() == WEAPON_SHIELD or weapon:getWeaponType() == WEAPON_AMMO or weapon:getWeaponType() == WEAPON_WAND then
			player:sendCancelMessage("The weapon does not exist.")
			return false
		end
	else
		if weapon ~= nil then
			weaponName = weapon:getName()
		end
	end
	
	local ammunition = getAmmunition(player)
	if ammunitionName ~= nil then
		ammunition = ItemType(ammunitionName)
		if ammunition == nil or ammunition:getWeaponType() ~= WEAPON_AMMO then
			player:sendCancelMessage("The ammunition does not exist.")
			return false
		end
	else
		if ammunition ~= nil then
			ammunitionName = ammunition:getName()
		end
	end
	
	local skillType = SKILL_FIST
	local attack = getAttack(weapon, ammunition)
	if weapon ~= nil then
		skillType = weaponSkillsConfig[weapon:getWeaponType()]
	end
	
	local skillValue = player:getSkillLevel(skillType)
	if skillValueNumber ~= nil then
		if tonumber(skillValueNumber) > 0 then
			if tonumber(skillValueNumber) <= 300 then
				skillValue = tonumber(skillValueNumber)
			else
				player:sendCancelMessage("The skill value has to be no bigger than 300.")
				return false
			end
		else
			player:sendCancelMessage("The skill value has to be a number and greater than zero.")
			return false
		end
	end
	
	local vocation = player:getVocation()
	if vocationName ~= nil then
		vocation = Vocation(vocationName)
		if vocation == nil then
			player:sendCancelMessage("The vocation does not exist.")
			return false
		end
	else
		vocationName = vocation:getName()
	end
	
	local commandStr = "Executing command: !physicaldamage " .. creatureName .. ", " .. skillValue .. ", " .. vocationName .. ""
	
	if weapon ~= nil then
		commandStr = commandStr .. ", " .. weaponName
	end
	
	if ammunition ~= nil and weapon ~= nil and weapon:getWeaponType() == WEAPON_DISTANCE then
		commandStr = commandStr .. ", " .. ammunitionName
	end
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, commandStr)
	
	local offensiveDamageContainer = getTotalDamage(creature, weapon, ammunition, vocation, attack, skillValue, FIGHTMODE_ATTACK)
	local balancedDamageContainer = getTotalDamage(creature, weapon, ammunition, vocation, attack, skillValue, FIGHTMODE_BALANCED)
	local defensiveDamageContainer = getTotalDamage(creature, weapon, ammunition, vocation, attack, skillValue, FIGHTMODE_DEFENSE)

	local message = ""
	message = message .. "Vocation: " .. vocation:getName() .. "\n"
	message = message .. "Skill Name: " .. skillNameConfig[skillType] .. ", Skill Value: " .. skillValue .. "\n"
	message = message .. "Weapon: " .. (weaponName or 'none') .. " (atk: " .. attack .. ")\n"
	message = message .. "Creature: " .. creatureName .. " (arm: " .. creature:getType():getArmor() .. ", def: " .. creature:getType():getDefense() .. ", skill: " .. creature:getType():getSkill() .. ")\n"
	message = message .. "\nOffensive Fighting Damage\n"
	message = message .. "Min: " .. offensiveDamageContainer[1] .. ", Max: " .. offensiveDamageContainer[2] .. "\n"
	message = message .. "\nBalanced Fighting Damage\n"
	message = message .. "Min: " .. balancedDamageContainer[1] .. ", Max: " .. balancedDamageContainer[2] .. "\n"
	message = message .. "\nDefensive Fighting Damage\n"
	message = message .. "Min: " .. defensiveDamageContainer[1] .. ", Max: " .. defensiveDamageContainer[2] .. "\n"
	
	message = message .. "\nFirst 100 Hits Damage Simulator in Offensive Fighting\n"
	local creatureHealth = creature:getType():getMaxHealth()
	local creatureHitsTillDeath = 1
	for i=1,100 do
		local damageContainer = getTotalDamage(creature, weapon, ammunition, vocation, attack, skillValue, FIGHTMODE_ATTACK)
		message = message .. "Hit: " .. i .. ", Damage: " .. damageContainer[0] .. "\n"
		creatureHealth = creatureHealth + damageContainer[0]
		if creatureHealth > 0 then
			creatureHitsTillDeath = creatureHitsTillDeath + 1
		end
	end

	if creatureHealth <= 0 then
		message = message .. "\nIt would take you approximately " .. creatureHitsTillDeath .. " hits to slain " .. creature:getName() .. ".\n"
	else
		message = message .. "\nIt would take you more than 100 hits to slain " .. creature:getName() .. ".\n"
	end
	player:showTextDialog(weapon and weapon:getId() or 2950, message, false)
	return false
end