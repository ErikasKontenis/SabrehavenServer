local tasks = {
	['crocodile'] = {progressStorage = 17608, killsRequired = 100},
	['tarantula'] = {progressStorage = 17608, killsRequired = 100},
	['carniphila'] = {progressStorage = 17608, killsRequired = 50},
	['merlkin'] = {progressStorage = 17608, killsRequired = 100},
	['kongra'] = {progressStorage = 17608, killsRequired = 100},
	['sibang'] = {progressStorage = 17608, killsRequired = 100},
	['thornback tortoise'] = {progressStorage = 17608, killsRequired = 100},
	['gargoyle'] = {progressStorage = 17608, killsRequired = 65},
	['quara constrictor scout'] = {progressStorage = 17608, killsRequired = 200},
	['quara hydromancer scout'] = {progressStorage = 17608, killsRequired = 200},
	['quara mantassin scout'] = {progressStorage = 17608, killsRequired = 200},
	['quara pincher scout'] = {progressStorage = 17608, killsRequired = 200},
	['quara predator scout'] = {progressStorage = 17608, killsRequired = 200},
	['ancient scarab'] = {progressStorage = 17608, killsRequired = 125},
	['wyvern'] = {progressStorage = 17608, killsRequired = 100},
	['bonebeast'] = {progressStorage = 17608, killsRequired = 100},
	['dragon'] = {progressStorage = 17608, killsRequired = 200},
}

function onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end

	local task = tasks[target:getName():lower()]
	if task ~= nil then
		local inProgressQuest = player:getStorageValue(task.progressStorage)
		if inProgressQuest > 0 then
			local playerQuestKills = player:getStorageValue(inProgressQuest)
			if playerQuestKills < task.killsRequired then
				player:setStorageValue(inProgressQuest, playerQuestKills + 1)
			end
		end
	end
	return true
end