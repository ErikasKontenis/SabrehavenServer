local config = {
	[17578] = { name = "edronorshabaal", message = "CHAMEK ATH UTHUL ARAK!", count=100 },
	[17579] = { name = "ferumbras", message = "Hahahaha! I have never been killed by the Avar Tar!", count=100 },
	[17580] = { name = "morgaroth", message = "THE TRIANGLE OF TERROR WILL RISE!", count=100 },
	[17581] = { name = "libertybaypirates", message = "Plundeeeeer!", count=100 }
}

function onStepIn(creature, item, position, fromPosition)
	doRelocate(item:getPosition(),{x = 33268, y = 31835, z = 9})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 33268, y = 31835, z = 9}, 11)
	item:getPosition():sendMonsterSay("Mystic flame ward you off.")
end

function onAddItem(item, tileitem, position)
	local movementId = tileitem:getMovementId()
	local raid = config[movementId]
	
	if (item:getId() ~= 5776) then
		doRelocate(item:getPosition(),{x = 33268, y = 31835, z = 9})
		item:getPosition():sendMagicEffect(11)
		Game.sendMagicEffect({x = 33268, y = 31835, z = 9}, 11)
		tileitem:getPosition():sendMonsterSay("Mystic flame spit out the sacrifice.")
		return true
	end
	
	local currentCount = getGlobalStorageValue(movementId) + item:getCount()
	setGlobalStorageValue(movementId, currentCount)
	if (currentCount >= raid.count) then
		item:getPosition():sendMonsterSay(raid.message)
		Game.startRaid(raid.name)
		tileitem:remove()
		setGlobalStorageValue(movementId, 0)
	end
	
	item:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
	item:remove()
end
