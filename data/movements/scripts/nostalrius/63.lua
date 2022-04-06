function onStepIn(creature, item, position, fromPosition)

end

function onAddItem(item, tileitem, position)
	doRelocate(tileitem:getPosition(),{x = tileitem:getPosition().x + 3, y = tileitem:getPosition().y, z = 07})
	Game.sendMagicEffect(tileitem:getPosition(), 13)
end
