function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	doRelocate(item:getPosition(),{x = 33090, y = 31759, z = 15}) 
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 33090, y = 31759, z = 15}, 11)
end

function onAddItem(item, tileitem, position)
	doRelocate(item:getPosition(),{x = 33090, y = 31759, z = 15})
	item:getPosition():sendMagicEffect(11)
	Game.sendMagicEffect({x = 33090, y = 31759, z = 15}, 11)
end
