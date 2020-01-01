local config = {
	[5908] = {
		-- Minotaurs
		[4011] = {value = 25000, newItem = 5878},
		[4047] = {value = 25000, newItem = 5878},
		[4057] = {value = 25000, newItem = 5878},
		[4052] = {value = 25000, newItem = 5878},

		-- Low Class Lizards
		[4321] = {value = 25000, newItem = 5876},
		[4327] = {value = 25000, newItem = 5876},
		[4324] = {value = 25000, newItem = 5876},

		-- Dragons
		[4025] = {value = 25000, newItem = 5877},

		-- Dragon Lords
		[4062] = {value = 25000, newItem = 5948},

		-- Behemoths
		[4112] = {value = 35000, newItem = 5893},

		-- Bone Beasts
		[4212] = {value = 25000, newItem = 5925},
	},
	[5942] = {
		-- Demon
		[4097] = {value = 25000, newItem = 5906},

		-- Vampires
		[4137] = {value = 25000, newItem = 5905}
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local skin = config[item.itemid][target.itemid]
	if not skin then
		return false
	end

	local random, effect, transform = math.random(1, 100000), CONST_ME_MAGIC_GREEN, true
	if type(skin[1]) == 'table' then
		local _skin
		for i = 1, #skin do
			_skin = skin[i]
			if random <= _skin.value then
				if isInArray({7441, 7442, 7444, 7445}, target.itemid) then
					player:addItem(_skin.newItem, _skin.amount or 1)
					effect = CONST_ME_HITAREA
				else
					player:addItem(_skin.newItem, _skin.amount or 1)
				end
				break
			end
		end

	elseif random <= skin.value then
		if isInArray({7441, 7442, 7444, 7445}, target.itemid) then
			player:addItem(skin.newItem, skin.amount or 1)
			effect = CONST_ME_HITAREA
		else
			player:addItem(skin.newItem, skin.amount or 1)
		end
	else
		if isInArray({7441, 7442, 7444, 7445}, target.itemid) then
			player:say('The attempt of sculpting failed miserably.', TALKTYPE_MONSTER_SAY)
			effect = CONST_ME_HITAREA
		else
			effect = CONST_ME_POFF
		end
	end

	toPosition:sendMagicEffect(effect)
	if transform then
		target:transform(skin.after or target.itemid + 1)
		target:decay()
	end

	return true
end