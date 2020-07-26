function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
	item:transform(2874, math.random(10, 11))
	return true
end
