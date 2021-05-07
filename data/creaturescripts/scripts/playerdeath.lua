local deathListEnabled = true
local maxDeathRecords = 50

function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
	
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are dead.")
   
    -- restart blessings values
    player:setStorageValue(101,0)
    player:setStorageValue(102,0)
    player:setStorageValue(103,0)
    player:setStorageValue(104,0)
    player:setStorageValue(105,0)
   
    if not deathListEnabled then
        return
    end

    local byPlayer = false
    local killerName
    if killer ~= nil then
        if killer:isPlayer() then
            byPlayer = true
        else
            local master = killer:getMaster()
            if master and master ~= killer and master:isPlayer() then
                killer = master
                byPlayer = true
            end
        end
        killerName = killer:getName()
    else
        killerName = "field item"
    end

    local byPlayerMostDamage = 0
    local mostDamageKillerName
    if mostDamageKiller ~= nil then
        if mostDamageKiller:isPlayer() then
            byPlayerMostDamage = 1
        else
            local master = mostDamageKiller:getMaster()
            if master and master ~= mostDamageKiller and master:isPlayer() then
                mostDamageKiller = master
                byPlayerMostDamage = 1
            end
        end
        mostDamageName = mostDamageKiller:getName()
    else
        mostDamageName = "field item"
    end

    local playerGuid = player:getGuid()
    db.query("INSERT INTO `player_deaths` (`player_id`, `time`, `level`, `killed_by`, `is_player`, `mostdamage_by`, `mostdamage_is_player`, `unjustified`, `mostdamage_unjustified`) VALUES (" .. playerGuid .. ", " .. os.time() .. ", " .. player:getLevel() .. ", " .. db.escapeString(killerName) .. ", " .. (byPlayer and 1 or 0) .. ", " .. db.escapeString(mostDamageName) .. ", " .. byPlayerMostDamage .. ", " .. (unjustified and 1 or 0) .. ", " .. (mostDamageUnjustified and 1 or 0) .. ")")
    local resultId = db.storeQuery("SELECT `player_id` FROM `player_deaths` WHERE `player_id` = " .. playerGuid)

    local deathRecords = 0
    local tmpResultId = resultId
    while tmpResultId ~= false do
        tmpResultId = result.next(resultId)
        deathRecords = deathRecords + 1
    end

    if resultId ~= false then
        result.free(resultId)
    end

    local limit = deathRecords - maxDeathRecords
    if limit > 0 then
        db.asyncQuery("DELETE FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. " ORDER BY `time` LIMIT " .. limit)
    end

    if not byPlayer then
        return
    end

    local warId = guildwars:isInWar(killer, player)
    if warId ~= 0 then
        guildwars:processKill(warId, killer, player)
    end
end