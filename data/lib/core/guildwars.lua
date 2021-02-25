guildwars = {}

guildwars.__index = guildwars

function guildwars:isInWar(player1, player2)
    if not player1:getGuild() or not player2:getGuild() then
        return 0
    end

    if player1:getGuild():getId() == 0 or player2:getGuild():getId() == 0 then
        return 0
    end

    if player1:getGuild():getId() == player2:getGuild():getId() then
        return 0
    end

    return isInWar(player1:getId(), player2:getId())
end

function guildwars:processKill(warId, killer, player)
    local fragLimit = self:getFragLimit(warId)

    local killerFrags = self:getKills(warId, killer:getGuild():getId()) + 1
    local deadFrags = self:getKills(warId, player:getGuild():getId())

    local killerMsg = "Opponent " .. player:getName() .. " of the " .. player:getGuild():getName() .. " was killed by " .. killer:getName() .. ". The new score is " .. killerFrags .. ":" .. deadFrags .. " frags (limit " .. fragLimit .. ")."
	sendGuildChannelMessage(killer:getGuild():getId(), TALKTYPE_CHANNEL_O, killerMsg)
	
    local deadMsg = "Guild member " .. player:getName() .. " was killed by " .. killer:getName() .. " of the " .. killer:getGuild():getName() .. ". The new score is " .. deadFrags .. ":" .. killerFrags .. " frags (limit " .. fragLimit .. ")."
	sendGuildChannelMessage(player:getGuild():getId(), TALKTYPE_CHANNEL_O, deadMsg)

    self:insertKill(warId, killer, player)

    if killerFrags >= fragLimit then
        self:endWar(warId, killer, player, killerFrags)
    end
end

function guildwars:getFragLimit(warId)
    local resultId = db.storeQuery("SELECT `frag_limit` FROM `guild_wars` WHERE `id` = " .. warId)
    if resultId ~= false then
        local frag_limit = result.getDataInt(resultId, "frag_limit")
        result.free(resultId)
        return frag_limit
    end
    return 0
end

function guildwars:getBounty(warId)
    local resultId = db.storeQuery("SELECT `bounty` FROM `guild_wars` WHERE `id` = " .. warId)
    if resultId ~= false then
        local bounty = result.getDataInt(resultId, "bounty")
        result.free(resultId)
        return bounty
    end
    return 0
end

function guildwars:getKills(warId, guildId)
    local resultId = db.storeQuery("SELECT COUNT(*) as frags FROM `guildwar_kills` WHERE `warid` = " .. warId .. " and `killerguild` = " .. guildId)
    if resultId ~= false then
        local frags = result.getDataInt(resultId, "frags")
        result.free(resultId)
        return frags
    end
    return 0
end

function guildwars:insertKill(warId, killer, target)
    db.asyncQuery("INSERT INTO `guildwar_kills` (`killer`, `target`, `killerguild`, `targetguild`, `warid`, `time`) VALUES (" .. db.escapeString(killer:getName()) .. ", " .. db.escapeString(target:getName()) .. ", " .. killer:getGuild():getId() .. ", " .. target:getGuild():getId() .. ", " .. warId .. ", " .. os.time() .. ")")
end

function guildwars:endWar(warId, killer, player, frags)
    local winGuildInternalMessage = "Congratulations! You have won the war against " .. player:getGuild():getName() .. " with " .. frags .. " frags."
	sendGuildChannelMessage(killer:getGuild():getId(), TALKTYPE_CHANNEL_O, winGuildInternalMessage)

    local loseGuildInternalMessage = "You have lost the war against " .. killer:getGuild():getName() .. ". They have reached the limit of " .. frags .. " frags."
	sendGuildChannelMessage(player:getGuild():getId(), TALKTYPE_CHANNEL_O, loseGuildInternalMessage)

    broadcastMessage(killer:getGuild():getName() .. " have won the war against " .. player:getGuild():getName() .. " with " .. frags .. " frags.", MESSAGE_EVENT_ADVANCE)

    self:updateState(warId, 5)

    self:setWarEmblem(killer:getGuild(), player:getGuild())
	
	local bounty = self:getBounty(warId)
	if bounty > 0 then
		killer:getGuild():increaseBankBalance(bounty * 2)
	end
end

function guildwars:setWarEmblem(guild1, guild2)
	guild1:setGuildWarEmblem(guild2)
end

function guildwars:updateState(warId, status)
    db.query("UPDATE `guild_wars` SET `status` = " .. status .. " WHERE `id` = " .. warId)
end

function guildwars:getPendingInvitation(guild1, guild2)
    local resultId = db.storeQuery("SELECT `id`, `bounty` FROM `guild_wars` WHERE `guild1` = " .. guild1 .. " AND `guild2` = " .. guild2 .. " AND `status` = 0")

    if resultId then
        local id = result.getDataInt(resultId, "id")
		local bounty = result.getDataInt(resultId, "bounty")
        result.free(resultId)

        return id, bounty
    end

    return 0
end

function guildwars:startWar(player, warId, guild1, guild2, bounty)
	if bounty > 0 then
		local guildBalance = guild1:getBankBalance()
		if guildBalance < bounty then
			player:sendCancelMessage("Your guild does not have that much money in the bank account balance to accept this war with the bounty of " .. bounty .. " gold.")
			return true
		end
		
		if not guild1:decreaseBankBalance(bounty) then
			player:sendCancelMessage("Your guild does not have that much money in the bank account balance to accept this war with the bounty of " .. bounty .. " gold.")
			return true
		end
	end

    self:updateState(warId, 1)

    self:setWarEmblem(guild1, guild2)

    broadcastMessage(guild1:getName() .. " has accepted " .. guild2:getName() .. " invitation to war.", MESSAGE_EVENT_ADVANCE)
end

function guildwars:rejectWar(warId, guild1, guild2, bounty)
    self:updateState(warId, 2)
    broadcastMessage(guild1:getName() .. " has rejected " .. guild2:getName() .. " invitation to war.", MESSAGE_EVENT_ADVANCE)
	
	if bounty > 0 then
		guild2:increaseBankBalance(bounty)
	end
end

function guildwars:cancelWar(warId, guild1, guild2, bounty)
    self:updateState(warId, 3)
    broadcastMessage(guild1:getName() .. " has canceled invitation to a war with " .. guild2:getName() .. ".", MESSAGE_EVENT_ADVANCE)
	
	if bounty > 0 then
		guild1:increaseBankBalance(bounty)
	end
end

function guildwars:invite(player, guild1, guild2, frags, bounty)
    local str = ""
    local tmpQuery = db.storeQuery("SELECT `guild1`, `status` FROM `guild_wars` WHERE `guild1` IN (" .. guild1:getId() .. "," .. guild2:getId() .. ") AND `guild2` IN (" .. guild2:getId() .. "," .. guild1:getId() .. ") AND `status` IN (0, 1)")
    if tmpQuery then
        if result.getDataInt(tmpQuery, "status") == 0 then
            if result.getDataInt(tmpQuery, "guild1") == guild1:getId() then
                str = "You have already invited " .. guild2:getName() .. " to war."
            else
                str = guild2:getName() .. " have already invited you to war."
            end
        else
            str = "You are already on a war with " .. guild2:getName() .. "."
        end

        result.free(tmpQuery)
    end

    if str ~= "" then
        player:sendCancelMessage(str)
        return true
    end

    frags = math.max(10, math.min(500, frags))
	bounty = math.max(0, math.min(10000000, bounty))
	
	if bounty > 0 then
		local guildBalance = guild1:getBankBalance()
		if guildBalance < bounty then
			player:sendCancelMessage("Your guild does not have that much money in the bank account balance to set this bounty.")
			return true
		end
		
		if not guild1:decreaseBankBalance(bounty) then
			player:sendCancelMessage("Your guild does not have that much money in the bank account balance to set this bounty.")
			return true
		end
	end
	
    db.asyncQuery("INSERT INTO `guild_wars` (`guild1`, `guild2`, `frag_limit`, `bounty`) VALUES (" .. guild1:getId() .. ", " .. guild2:getId() .. ", " .. frags .. ", " .. bounty .. ");")
	
	local message = guild1:getName() .. " has invited " .. guild2:getName() .. " to war for " .. frags .. " frags."
	if bounty > 0 then
		message = message .. " The bounty reward is set to " .. bounty .. " gold."
	end
    broadcastMessage(message, MESSAGE_EVENT_ADVANCE)
end