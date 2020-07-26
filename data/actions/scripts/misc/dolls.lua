local dolls = {
	[5080] = {"Hug me."},
	[5668] = {
		"It's not winning that matters, but winning in style.",
		"Today's your lucky day. Probably.",
		"Do not meddle in the affairs of dragons, for you are crunchy and taste good with ketchup.",
		"That is one stupid question.",
		"You'll need more rum for that.",
		"Do or do not. There is no try.",
		"You should do something you always wanted to.",
		"If you walk under a ladder and it falls down on you it probably means bad luck.",
		"Never say 'oops'. Always say 'Ah, interesting!'",
		"Five steps east, fourteen steps south, two steps north and seventeen steps west!"
	},
	[5791] = {
		"Fchhhhhh!",
		"Zchhhhhh!",
		"Grooaaaaar*cough*",
		"Aaa... CHOO!",
		"You... will.... burn!!"
	},
	[6511] = {
		"Ho ho ho",
		"Jingle bells, jingle bells...",
		"Have you been naughty?",
		"Have you been nice?",
		"Merry Christmas!",
		"Can you stop squeezing me now... I'm starting to feel a little sick."
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local sounds = dolls[item.itemid]
	if not sounds then
		return false
	end

	if fromPosition.x == CONTAINER_POSITION then
		fromPosition = player:getPosition()
	end

	local random = math.random(#sounds)
	local sound = sounds[random]
	if item.itemid == 5791 then
		if random == 3 then
			fromPosition:sendMagicEffect(CONST_ME_POFF)
		elseif random == 4 then
			fromPosition:sendMagicEffect(CONST_ME_FIREAREA)
		elseif random == 5 then
			doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -1, -1, CONST_ME_EXPLOSIONHIT)
		end
		
		if configManager.getNumber(configKeys.CLIENT_VERSION) >= 790 then
			item:transform(6566)
			item:decay()
		end
	elseif item.itemid == 5668 then
		fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
		item:transform(item.itemid + 1)
		item:decay()
	elseif item.itemid == 5080 then
		if configManager.getNumber(configKeys.CLIENT_VERSION) >= 790 then
			item:transform(6568)
			item:decay()
		end
	elseif item.itemid == 6511 then
		item:transform(6567)
		item:decay()
	end

	sound = sound:gsub('|PLAYERNAME|', player:getName())
	player:say(sound, TALKTYPE_MONSTER_SAY, false, 0, fromPosition)
	return true
end
