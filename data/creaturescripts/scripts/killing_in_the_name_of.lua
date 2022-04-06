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
	['frost troll'] = {taskerStorage = 17608, progressStorage = 17697, killsRequired = 100},
	['swamp troll'] = {taskerStorage = 17608, progressStorage = 17698, killsRequired = 100},
	['rat'] = {taskerStorage = 17608, progressStorage = 17699, killsRequired = 25},
	['cave rat'] = {taskerStorage = 17608, progressStorage = 17699, killsRequired = 25},
	['wolf'] = {taskerStorage = 17608, progressStorage = 17700, killsRequired = 100},
	['winter wolf'] = {taskerStorage = 17608, progressStorage = 17700, killsRequired = 100},
	['wasp'] = {taskerStorage = 17608, progressStorage = 17701, killsRequired = 100},
	['larva'] = {taskerStorage = 17608, progressStorage = 17702, killsRequired = 100},
	['dwarf'] = {taskerStorage = 17608, progressStorage = 17703, killsRequired = 100},
	['skeleton'] = {taskerStorage = 17608, progressStorage = 17704, killsRequired = 100},
	['ghoul'] = {taskerStorage = 17608, progressStorage = 17704, killsRequired = 100},
	['elf'] = {taskerStorage = 17608, progressStorage = 17729, killsRequired = 200},
	['elf scout'] = {taskerStorage = 17608, progressStorage = 17729, killsRequired = 200},
	['elf arcanist'] = {taskerStorage = 17608, progressStorage = 17729, killsRequired = 200},
	['bug'] = {taskerStorage = 17608, progressStorage = 17730, killsRequired = 40},
	['smuggler'] = {taskerStorage = 17608, progressStorage = 17731, killsRequired = 250},
	['wild warrior'] = {taskerStorage = 17608, progressStorage = 17731, killsRequired = 250},
	['bandit'] = {taskerStorage = 17608, progressStorage = 17731, killsRequired = 250},
	['hyaena'] = {taskerStorage = 17608, progressStorage = 17732, killsRequired = 30},
	['lion'] = {taskerStorage = 17608, progressStorage = 17733, killsRequired = 20},
	['bear'] = {taskerStorage = 17608, progressStorage = 17734, killsRequired = 35},
	['slime'] = {taskerStorage = 17608, progressStorage = 17735, killsRequired = 100},
	['beholder'] = {taskerStorage = 17608, progressStorage = 17736, killsRequired = 250},
	['elder beholder'] = {taskerStorage = 17608, progressStorage = 17736, killsRequired = 250},
	['green djinn'] = {taskerStorage = 17608, progressStorage = 17737, killsRequired = 500},
	['blue djinn'] = {taskerStorage = 17608, progressStorage = 17737, killsRequired = 500},
	['marid'] = {taskerStorage = 17608, progressStorage = 17737, killsRequired = 500},
	['efreet'] = {taskerStorage = 17608, progressStorage = 17737, killsRequired = 500},
	['pirate skeleton'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['pirate marauder'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['pirate cutthroat'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['pirate ghost'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['pirate buccaneer'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['pirate corsair'] = {taskerStorage = 17608, progressStorage = 17738, killsRequired = 600},
	['orc spearman'] = {taskerStorage = 17608, progressStorage = 17712, killsRequired = 300},
	['orc shaman'] = {taskerStorage = 17608, progressStorage = 17712, killsRequired = 300},
	['orc rider'] = {taskerStorage = 17608, progressStorage = 17712, killsRequired = 300},
	['orc warrior'] = {taskerStorage = 17608, progressStorage = 17712, killsRequired = 300},
	['orc berserker'] = {taskerStorage = 17608, progressStorage = 17712, killsRequired = 300},
	['minotaur archer'] = {taskerStorage = 17608, progressStorage = 17713, killsRequired = 300},
	['minotaur guard'] = {taskerStorage = 17608, progressStorage = 17713, killsRequired = 300},
	['minotaur mage'] = {taskerStorage = 17608, progressStorage = 17713, killsRequired = 300},
	['lizard templar'] = {taskerStorage = 17608, progressStorage = 17714, killsRequired = 300},
	['lizard sentinel'] = {taskerStorage = 17608, progressStorage = 17714, killsRequired = 300},
	['lizard snakecharmer'] = {taskerStorage = 17608, progressStorage = 17714, killsRequired = 300},
	['dwarf soldier'] = {taskerStorage = 17608, progressStorage = 17715, killsRequired = 300},
	['dwarf guard'] = {taskerStorage = 17608, progressStorage = 17715, killsRequired = 300},
	['dwarf geomancer'] = {taskerStorage = 17608, progressStorage = 17715, killsRequired = 300},
	['ghost'] = {taskerStorage = 17608, progressStorage = 17716, killsRequired = 200},
	['demon skeleton'] = {taskerStorage = 17608, progressStorage = 17716, killsRequired = 200},
	['vampire'] = {taskerStorage = 17608, progressStorage = 17716, killsRequired = 200},
	['orc leader'] = {taskerStorage = 17608, progressStorage = 17717, killsRequired = 125},
	['orc warlord'] = {taskerStorage = 17608, progressStorage = 17717, killsRequired = 125},
	['hero'] = {taskerStorage = 17608, progressStorage = 17718, killsRequired = 150},
	['necromancer'] = {taskerStorage = 17608, progressStorage = 17719, killsRequired = 300},
	['priestess'] = {taskerStorage = 17608, progressStorage = 17719, killsRequired = 300},
	['nightmare'] = {taskerStorage = 17608, progressStorage = 17720, killsRequired = 150},
	['warlock'] = {taskerStorage = 17608, progressStorage = 17721, killsRequired = 300},
	['demon'] = {taskerStorage = 17608, progressStorage = 17722, killsRequired = 6666},
	
	-- Daniel Steelsoul
	['troll'] = {taskerStorage = 17632, progressStorage = 17633, killsRequired = 100},
	['goblin'] = {taskerStorage = 17632, progressStorage = 17634, killsRequired = 150},
	['rotworm'] = {taskerStorage = 17632, progressStorage = 17635, killsRequired = 150},
	['carrion worm'] = {taskerStorage = 17632, progressStorage = 17635, killsRequired = 150},
	['cyclops'] = {taskerStorage = 17632, progressStorage = 17636, killsRequired = 150},
	
	-- Young Vocation Tasks
	['amazon'] = {taskerStorage = 17644, progressStorage = 17645, killsRequired = 50},
	['minotaur'] = {taskerStorage = 17649, progressStorage = 17648, killsRequired = 50},
	['orc'] = {taskerStorage = 17652, progressStorage = 17651, killsRequired = 50},
}

local maxPlayersInPartyShare = 10

function onDeath(creature, corpse, lasthitkiller, mostdamagekiller, lasthitunjustified, mostdamageunjustified)
	if not creature:isMonster() or creature:getMaster() then
		return true
	end
	
	if mostdamagekiller == nil then
		return true
	end
	
	local player = mostdamagekiller
	if not mostdamagekiller:isPlayer() then
		local master = mostdamagekiller:getMaster()
		if master and master:isPlayer() then
			player = master
		else
			return true
		end
	end
	
	local targetName = creature:getName():lower()
	local task = tasks[targetName]
	if task ~= nil then
		local players
		local party = player:getParty()
		if party ~= nil and party:isSharedExperienceActive() then
			players = party:getMembers() -- all members of the party
			players[#players + 1] = party:getLeader() -- don't forget the leader
		else
			players = { player } -- no party? then just the player
		end

		for i, member in ipairs(players) do
			if i <= maxPlayersInPartyShare then
				local inProgressQuest = member:getStorageValue(task.taskerStorage)
				if inProgressQuest == task.progressStorage then
					local playerQuestKills = member:getStorageValue(task.progressStorage)
					if playerQuestKills < task.killsRequired then
						member:setStorageValue(task.progressStorage, playerQuestKills + 1)
						member:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[Task Tracker] You have killed " .. playerQuestKills + 1 .. "/" .. task.killsRequired .. " " .. targetName .. ".")
					end
				end
			end
		end
	end
    return true
end