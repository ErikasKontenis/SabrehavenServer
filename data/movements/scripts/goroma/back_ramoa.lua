function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(17510) ~= 1 then
		player:setStorageValue(17510, 1) 
		return true
	end
	
	doRelocate(item:getPosition(),{x = 32036, y = 32558, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32036, y = 32558, z = 08}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 32036, y = 32558, z = 08})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 32036, y = 32558, z = 08}, 11)
end
