function onUse(player, item, fromPosition, target, toPosition)
	item:getPosition():sendMagicEffect(CONST_ME_POFF)
	item:transform(6278, 1)
	item:getPosition():sendMonsterSay(player:getName() .. " blew out the candle.")
	return true
end
