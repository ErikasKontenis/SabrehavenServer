local config = {
	[6570] = { -- bluePresent
		{3598, 10}, {6393, 3}, 6279, 6574, 6578, 6575, 6577, 6569, 6576, 6572, 2995
	},
	[6571] = { -- redPresent
		{3035, 10}, {3035, 10}, {3035, 10}, 3036, 5944, 2993, 6568, 6566, 3386, 3420, 3079, 2995, 2995, 2995, 6393, 6393, 6576, 6576, 6578, 6578, 6574, 6574
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local present = config[item.itemid]
	if not present then
		return false
	end

	local count = 1
	local gift = present[math.random(#present)]
	if type(gift) == "table" then
		count = gift[2]
		gift = gift[1]
	end

	player:addItem(gift, count)
	item:remove(1)
	fromPosition:sendMagicEffect(CONST_ME_GIFT_WRAPS)
	return true
end