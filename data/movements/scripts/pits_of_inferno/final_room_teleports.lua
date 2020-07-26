local config = {
	[17660] = Position(32835, 32275, 9), -- exit
	[17661] = Position(32856, 32353, 15), -- Verminor Enter
	[17662] = Position(32848, 32230, 15), -- Infernatil Enter
	[17663] = Position(32767, 32227, 15), -- Tafariel Enter
	[17664] = Position(32856, 32278, 15), -- Apocalypse Enter
	[17665] = Position(32733, 32297, 15), -- Pumin Enter
	[17666] = Position(32806, 32328, 15), -- Bazir Enter
	[17667] = Position(32835, 32262, 15), -- Ashfalor Enter
	[17668] = Position(32830, 32252, 10), -- reward room Enter
	[17669] = Position(32821, 32244, 12), -- Verminor Exit
	[17670] = Position(32821, 32241, 12), -- Infernatil Exit
	[17671] = Position(32821, 32238, 12), -- Tafariel Exit
	[17672] = Position(32824, 32237, 12), -- Apocalypse Exit
	[17673] = Position(32827, 32238, 12), -- Pumin Exit
	[17674] = Position(32827, 32241, 12), -- Bazir Exit
	[17675] = Position(32827, 32244, 12), -- Ashfalor Exit
	[17676] = Position(32824, 32232, 12), -- reward room Exit
	[17677] = Position(32829, 32243, 11), -- chest room enter
	[17678] = Position(32826, 32248, 10) -- chest room exit
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(17510) ~= 1 then
		player:setStorageValue(17510, 1) 
		return true
	end
	
	local targetPosition = config[item:getMovementId()]
	doRelocate(item:getPosition(), targetPosition)
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect(targetPosition, 11)
end

function onAddItem(item, tileitem, position)
	local targetPosition = config[tileitem:getMovementId()]
	doRelocate(item:getPosition(),targetPosition)
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect(targetPosition, 11)
end
