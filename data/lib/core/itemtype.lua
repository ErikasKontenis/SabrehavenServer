local slotBits = {
	[CONST_SLOT_HEAD] = SLOTP_HEAD,
	[CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
	[CONST_SLOT_BACKPACK] = SLOTP_BACKPACK,
	[CONST_SLOT_ARMOR] = SLOTP_ARMOR,
	[CONST_SLOT_RIGHT] = SLOTP_RIGHT,
	[CONST_SLOT_LEFT] = SLOTP_LEFT,
	[CONST_SLOT_LEGS] = SLOTP_LEGS,
	[CONST_SLOT_FEET] = SLOTP_FEET,
	[CONST_SLOT_RING] = SLOTP_RING,
	[CONST_SLOT_AMMO] = SLOTP_AMMO
}

function ItemType.usesSlot(self, slot)
	return bit.band(self:getSlotPosition(), slotBits[slot] or 0) ~= 0
end

function ItemType.isHelmet(self)
	return self:usesSlot(CONST_SLOT_HEAD)
end

function ItemType.isArmor(self)
	return self:usesSlot(CONST_SLOT_ARMOR)
end

function ItemType.isLegs(self)
	return self:usesSlot(CONST_SLOT_LEGS)
end

function ItemType.isBoots(self)
	return self:usesSlot(CONST_SLOT_FEET)
end

local notWeapons = {WEAPON_NONE, WEAPON_SHIELD, WEAPON_AMMO}
function ItemType.isWeapon(self)
	return not table.contains(notWeapons, self:getWeaponType())
end

function ItemType.isTwoHanded(self)
	return bit.band(self:getSlotPosition(), SLOTP_TWO_HAND) ~= 0
end

function ItemType.isBow(self)
	local ammoType = self:getAmmoType()
	return self:getWeaponType() == WEAPON_DISTANCE and (ammoType == AMMO_ARROW or ammoType == AMMO_BOLT)
end

function ItemType.isMissile(self)
	local ammoType = self:getAmmoType()
	return self:getWeaponType() == WEAPON_DISTANCE and ammoType ~= AMMO_ARROW and ammoType ~= AMMO_BOLT
end

function ItemType.isWand(self)
	return self:getWeaponType() == WEAPON_WAND
end

function ItemType.isShield(self)
	return self:getWeaponType() == WEAPON_SHIELD
end

function ItemType.isBackpack(self)
	return self:usesSlot(CONST_SLOT_BACKPACK)
end

function ItemType.isNecklace(self)
	return self:usesSlot(CONST_SLOT_NECKLACE)
end

function ItemType.isRing(self)
	return self:usesSlot(CONST_SLOT_RING)
end

function ItemType.isAmmo(self)
	return self:getWeaponType() == WEAPON_AMMO
end

function ItemType.isTrinket(self)
	return self:usesSlot(CONST_SLOT_AMMO) and self:getWeaponType() == WEAPON_NONE
end

function ItemType.isBed(self)
	return self:getType() == ITEM_TYPE_BED
end

function ItemType.getWeaponString(self)
	local weaponType = self:getWeaponType()
	local weaponString = "unknown"

	if weaponType == WEAPON_CLUB then
		weaponString = "blunt instrument"
	elseif weaponType == WEAPON_SWORD then
		weaponString = "stabbing weapon"
	elseif weaponType == WEAPON_AXE then
		weaponString = "cutting weapon"
	elseif weaponType == WEAPON_DISTANCE then
		weaponString = self:isBow() and "firearm" or "missile"
	elseif weaponType == WEAPON_WAND then
		weaponString = "wand/rod"
	end

	if self:isTwoHanded() then
		weaponString = string.format("%s, two-handed", weaponString)
	end

	return weaponString
end