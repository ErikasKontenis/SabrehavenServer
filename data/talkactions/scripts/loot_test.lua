local config = {
	['exp'] = {skillKey = 17585, timeKey = 17589},
	['skill'] = {skillKey = 17586, timeKey = 17590},
	['magic'] = {skillKey = 17587, timeKey = 17591},
	['loot'] = {skillKey = 17588, timeKey = 17592} -- TODO
}

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	local i = 0
	local function generateMonsterLoad()
		if (i <= 1000) then
			Game.createMonster("cyclops", {x = 32316, y = 31942, z = 7})
			local monster = Game.isMonsterThere({x = 32316, y = 31942, z = 7}, "cyclops")
			monster:addHealth(-monster:getMaxHealth())
			addEvent(generateMonsterLoad, 1000)
			i = i + 1
			print(i)
		end
	end
	
	addEvent(generateMonsterLoad, 1000)
	
	return false
end

