local food = {
	3577, 3582, 3585, 3592, 3602
}

function onCastSpell(creature, variant)
	local player = Player(creature:getId())
	if player then
		if SafeZone.cache_players[player:getId()] then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You can't use spells inside of this event.")
			return false
		end
	end
	creature:addItem(food[math.random(#food)])
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end