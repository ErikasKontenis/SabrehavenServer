local weaponSkillsConfig = {
	[WEAPON_SWORD] = SKILL_SWORD,
	[WEAPON_CLUB] = SKILL_CLUB,
	[WEAPON_AXE] = SKILL_AXE,
	[WEAPON_DISTANCE] = SKILL_DISTANCE
}

local function getWeapon(player)
	local itemLeft = player:getSlotItem(CONST_SLOT_LEFT)
	if itemLeft and itemLeft:getType():getWeaponType() ~= WEAPON_NONE and itemLeft:getType():getWeaponType() ~= WEAPON_SHIELD and itemLeft:getType():getWeaponType() ~= WEAPON_AMMO then
		return itemLeft
	end
	
	local itemRight = player:getSlotItem(CONST_SLOT_RIGHT)
	if itemRight and itemRight:getType():getWeaponType() ~= WEAPON_NONE and itemRight:getType():getWeaponType() ~= WEAPON_SHIELD and itemRight:getType():getWeaponType() ~= WEAPON_AMMO then
		return itemRight
	end
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

local function getMinDamage(attack, attackSkill, fightMode)
	local formula = getDamageFormula(attack, attackSkill, fightMode)
	local damage = -math.floor((math.ceil(formula * (0 / 2) / 10000.)));
	return damage
end

local function getMaxDamage(attack, attackSkill, fightMode)
	local formula = getDamageFormula(attack, attackSkill, fightMode)
	local damage = -math.floor((math.ceil(formula * (198 / 2) / 10000.)));
	return damage
end

local function setVocationDamageIncrease(vocationId, damage)
	local knightCloseAttackDamageIncreasePercent = configManager.getNumber(configKeys.KNIGHT_CLOSE_ATTACK_DAMAGE_INCREASE_PERCENT)
	if knightCloseAttackDamageIncreasePercent ~= -1 then
		damage = math.floor(damage + damage * knightCloseAttackDamageIncreasePercent / 100);
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

local function setDamageBlock(creature, damage, random1, random2, randomArmor)
	if bit.band(creature:getType():getCombatImmunities(), COMBAT_PHYSICALDAMAGE) == COMBAT_PHYSICALDAMAGE then
		return 0
	end

	damage = damage + getDefense(creature, random1, random2)

	if damage >= 0 then
		return 0
	end
	
	if damage < 0 then
	print (getArmor(creature, randomArmor))
		damage = damage + getArmor(creature, randomArmor)
		if damage >= 0 then
			return 0
		end
	end

	return damage
end

function onSay(player, words, param)
	local split = param:split(",")
	if split[3] == nil then
		--player:sendCancelMessage("Insufficient parameters [(exp,skill,loot,magic),percentage,hours].")
		--return false
	end
	
	local creature = Creature("Troll")
	if creature == nil then
		player:sendCancelMessage("The monster does not exist.")
	end
	
	local skillType = SKILL_FIST
	local attack = 7
	local weapon = getWeapon(player)
	if weapon ~= nil then
		attack = weapon:getType():getAttack()
		skillType = weaponSkillsConfig[weapon:getType():getWeaponType()]
	end

	local damage = setDamageBlock(creature, setVocationDamageIncrease(player:getVocation():getId(), getDamage(attack, player:getSkillLevel(skillType), FIGHTMODE_ATTACK, os.rand(), os.rand())), os.rand(), os.rand(), os.rand())
	local minDamage = setDamageBlock(creature, setVocationDamageIncrease(player:getVocation():getId(), getDamage(attack, player:getSkillLevel(skillType), FIGHTMODE_ATTACK, 0, 0)), 99, 99, rshift(creature:getType():getArmor(), 1) + 1)
	local maxDamage = setDamageBlock(creature, setVocationDamageIncrease(player:getVocation():getId(), getDamage(attack, player:getSkillLevel(skillType), FIGHTMODE_ATTACK, 99, 99)), 0, 0, 0)

	print ("TotalDamage:" .. damage)
	print ("MinDamage:" .. minDamage)
	print ("MaxDamage:" .. maxDamage)
	--print (weapon:getType():getAttack())
	--print (shield:getName())
	local message = ""
	message = message .. "Offensive Fighting\n"
	message = message .. "- Daily kills for red skull " .. 123 .. "\n"
	--player:showTextDialog(1998, message, false)
	return false
end