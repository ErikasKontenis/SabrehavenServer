function onRemoveItem(item, tileitem, position)
	local demonsInRoomCount = 0;
	local spectators = Game.getSpectators(Position(33063, 31624, 15), false, false, 20, 20, 20, 20)
	for i = 1, #spectators do
        local creature = spectators[i]
		if creature:getName():lower() == "demon" then
			demonsInRoomCount = demonsInRoomCount + 1
		end
    end

	if (demonsInRoomCount <= 1) then
		local demon1 = Game.isMonsterThere({x = 33336, y = 31954, z = 15}, "Demon")
		local demon2 = Game.isMonsterThere({x = 33340, y = 31954, z = 15}, "Demon")
		local demon3 = Game.isMonsterThere({x = 33340, y = 31958, z = 15}, "Demon")
		local demon4 = Game.isMonsterThere({x = 33336, y = 31958, z = 15}, "Demon")
		if demon1 ~= nil and demon2 ~= nil and demon3 ~= nil and demon4 ~= nil then
			demon1:addHealth(-demon1:getMaxHealth())
			demon2:addHealth(-demon2:getMaxHealth())
			demon3:addHealth(-demon3:getMaxHealth())
			demon4:addHealth(-demon4:getMaxHealth())
			Game.createMonster("Demon", {x = 33060, y = 31623, z = 15})
			Game.createMonster("Demon", {x = 33066, y = 31623, z = 15})
			Game.createMonster("Demon", {x = 33066, y = 31627, z = 15})
			Game.createMonster("Demon", {x = 33060, y = 31627, z = 15})
			Game.sendMagicEffect({x = 33060, y = 31622, z = 15}, 14)
			Game.sendMagicEffect({x = 33066, y = 31622, z = 15}, 14)
			Game.sendMagicEffect({x = 33066, y = 31628, z = 15}, 14)
			Game.sendMagicEffect({x = 33060, y = 31628, z = 15}, 14)
		end
	end
end