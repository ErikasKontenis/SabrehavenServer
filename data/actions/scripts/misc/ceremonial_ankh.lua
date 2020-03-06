local blessings = {
	{key = 101, value = 1, name = 'Wisdom of Solitude'},
	{key = 102, value = 1, name = 'Spark of the Phoenix'},
	{key = 103, value = 3, name = 'Fire of the Suns'},
	{key = 104, value = 1, name = 'Spiritual Shielding'},
	{key = 105, value = 1, name = 'Embrace of Tibia'}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local result, bless = 'Received blessings:'
	for i = 1, #blessings do
		bless = blessings[i]
		result = (player:getStorageValue(bless.key) == bless.value) and result .. '\n' .. bless.name or result
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 20 > result:len() and 'No blessings received.' or result)
	return true
end
