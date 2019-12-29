local config = {
	[6087] = {storage = 1053, text = 'first', effect = CONST_ME_SOUND_GREEN},
	[6088] = {storage = 1054, text = 'second', effect = CONST_ME_SOUND_RED},
	[6089] = {storage = 1055, text = 'third', effect = CONST_ME_SOUND_YELLOW},
	[6090] = {storage = 1056, text = 'fourth', effect = CONST_ME_SOUND_BLUE}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPosition = player:getPosition()
	local useItem = config[item.itemid]
	if player:getStorageValue(useItem.storage) ~= 1 then
		player:setStorageValue(useItem.storage, 1)
		player:say("You have learned the ".. useItem.text .." part of a hymn.", TALKTYPE_MONSTER_SAY, false, 0, playerPosition)
		playerPosition:sendMagicEffect(useItem.effect)
		item:remove(1)
	else
		player:say("You already know the ".. useItem.text .." verse of the hymn.", TALKTYPE_MONSTER_SAY, false, 0, playerPosition)
	end

	return true
end