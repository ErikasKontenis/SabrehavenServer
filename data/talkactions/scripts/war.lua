function onSay(player, words, param)
    if not player:getGuild() or player:getGuildLevel() < 3 then
        player:sendCancelMessage("You cannot execute this talkaction.")
        return true
    end

    local t = param:split(",")

    if not t[2] then
        player:sendCancelMessage("Not enough param(s).")
        return true
    end

    local enemyGuildName = string.trim(t[2])

    local enemyGuild = Guild(getGuildId(enemyGuildName))
    if not enemyGuild then
        player:sendCancelMessage("Guild \"" .. enemyGuildName .. "\" does not exists or nobody is online from the guild.")
        return true
    end

    if enemyGuild:getId() == player:getGuild():getId() then
        player:sendCancelMessage("You cannot perform war action on your own guild.")
        return true
    end
   
    local warCommand = string.trim(t[1])

    if isInArray({"accept", "reject", "cancel"}, warCommand) then
        local pendingWarId, bounty = 0

        if warCommand == "cancel" then
            pendingWarId, bounty = guildwars:getPendingInvitation(player:getGuild():getId(), enemyGuild:getId())
        else
            pendingWarId, bounty = guildwars:getPendingInvitation(enemyGuild:getId(), player:getGuild():getId())
        end

        if pendingWarId == 0 then
            player:sendCancelMessage("Currently there's no pending invitation for a war with " .. enemyGuild:getName() .. ".")
            return true
        end

        if warCommand == "reject" then
            guildwars:rejectWar(pendingWarId, player:getGuild(), enemyGuild, bounty)
        elseif warCommand == "cancel" then
            guildwars:cancelWar(pendingWarId, player:getGuild(), enemyGuild, bounty)
        else
            guildwars:startWar(player, pendingWarId, player:getGuild(), enemyGuild, bounty)
        end
   
        return true
    end

    if warCommand == "invite" then
        guildwars:invite(player, player:getGuild(), enemyGuild, tonumber(t[3] and string.trim(t[3]) or 100), tonumber(t[4] and string.trim(t[4]) or 0))
        return true
    end

    return true
end