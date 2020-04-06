local tasks = {
	-- Grizzly Adams
	['crocodile'] = {taskerStorage = 17608, progressStorage = 17609, killsRequired = 100},
	['tarantula'] = {taskerStorage = 17608, progressStorage = 17610, killsRequired = 100},
	['carniphila'] = {taskerStorage = 17608, progressStorage = 17611, killsRequired = 50},
	['merlkin'] = {taskerStorage = 17608, progressStorage = 17612, killsRequired = 100},
	['kongra'] = {taskerStorage = 17608, progressStorage = 17612, killsRequired = 100},
	['sibang'] = {taskerStorage = 17608, progressStorage = 17612, killsRequired = 100},
	['thornback tortoise'] = {taskerStorage = 17608, progressStorage = 17613, killsRequired = 100},
	['gargoyle'] = {taskerStorage = 17608, progressStorage = 17614, killsRequired = 65},
	['quara constrictor scout'] = {taskerStorage = 17608, progressStorage = 17616, killsRequired = 200},
	['quara hydromancer scout'] = {taskerStorage = 17608, progressStorage = 17616, killsRequired = 200},
	['quara mantassin scout'] = {taskerStorage = 17608, progressStorage = 17616, killsRequired = 200},
	['quara pincher scout'] = {taskerStorage = 17608, progressStorage = 17616, killsRequired = 200},
	['quara predator scout'] = {taskerStorage = 17608, progressStorage = 17616, killsRequired = 200},
	['ancient scarab'] = {taskerStorage = 17608, progressStorage = 17617, killsRequired = 125},
	['wyvern'] = {taskerStorage = 17608, progressStorage = 17618, killsRequired = 100},
	['bonebeast'] = {taskerStorage = 17608, progressStorage = 17619, killsRequired = 100},
	['dragon'] = {taskerStorage = 17608, progressStorage = 17620, killsRequired = 200},
	['quara constrictor'] = {taskerStorage = 17608, progressStorage = 17621, killsRequired = 600},
	['quara hydromancer'] = {taskerStorage = 17608, progressStorage = 17621, killsRequired = 600},
	['quara mantassin'] = {taskerStorage = 17608, progressStorage = 17621, killsRequired = 600},
	['quara pincher'] = {taskerStorage = 17608, progressStorage = 17621, killsRequired = 600},
	['quara predator'] = {taskerStorage = 17608, progressStorage = 17621, killsRequired = 600},
	['giant spider'] = {taskerStorage = 17608, progressStorage = 17622, killsRequired = 500},
	['banshee'] = {taskerStorage = 17608, progressStorage = 17623, killsRequired = 300},
	['lich'] = {taskerStorage = 17608, progressStorage = 17624, killsRequired = 500},
	['acolyte of the cult'] = {taskerStorage = 17608, progressStorage = 17625, killsRequired = 500},
	['adept of the cult'] = {taskerStorage = 17608, progressStorage = 17625, killsRequired = 500},
	['enlightened of the cult'] = {taskerStorage = 17608, progressStorage = 17625, killsRequired = 500},
	['novice of the cult'] = {taskerStorage = 17608, progressStorage = 17625, killsRequired = 500},
	['hydra'] = {taskerStorage = 17608, progressStorage = 17626, killsRequired = 650},
	['serpent spawn'] = {taskerStorage = 17608, progressStorage = 17627, killsRequired = 800},
	['behemoth'] = {taskerStorage = 17608, progressStorage = 17628, killsRequired = 700},
	['dragon lord'] = {taskerStorage = 17608, progressStorage = 17629, killsRequired = 600},
	['hand of cursed fate'] = {taskerStorage = 17608, progressStorage = 17630, killsRequired = 200},
	['juggernaut'] = {taskerStorage = 17608, progressStorage = 17631, killsRequired = 200},
	
	-- Daniel Steelsoul
	['troll'] = {taskerStorage = 17632, progressStorage = 17633, killsRequired = 100},
	['goblin'] = {taskerStorage = 17632, progressStorage = 17634, killsRequired = 150},
	['rotworm'] = {taskerStorage = 17632, progressStorage = 17635, killsRequired = 150},
	['carrion worm'] = {taskerStorage = 17632, progressStorage = 17635, killsRequired = 150},
	['cyclops'] = {taskerStorage = 17632, progressStorage = 17636, killsRequired = 500},
}

function onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end

	local task = tasks[target:getName():lower()]
	if task ~= nil then
		local inProgressQuest = player:getStorageValue(task.taskerStorage)
		if inProgressQuest == task.progressStorage then
			local playerQuestKills = player:getStorageValue(task.progressStorage)
			if playerQuestKills < task.killsRequired then
				player:setStorageValue(task.progressStorage, playerQuestKills + 1)
			end
		end
	end
	return true
end