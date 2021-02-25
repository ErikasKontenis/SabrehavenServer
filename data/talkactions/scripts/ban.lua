local banDays = 7

function onSay(cid, words, param)
    local player = Player(cid)
    if not player:getGroup():getAccess() then
        return true
    end

    local name = param
    local reason = ''
    local banInfo = ''
    local banTime = 0
    local banMultiplier = 0
    local params = param:split(',')
    if params ~= nil then
        name = params[1]
        reason = string.trim(params[2])
        banInfo = string.trim(params[3])
		print(banInfo)
    end
    if banInfo then
        if banInfo:find('h') then
            banTime = banInfo:sub(0, banInfo:find('h') - 1)
            banMultiplier = 3600
        elseif banInfo:find('d') then
            banTime = banInfo:sub(0, banInfo:find('d') - 1)
            banMultiplier = 86400
        else
            banTime = banDays
            banMultiplier = 86400
        end
        banTime = banTime * banMultiplier
    end
   
    local accountId = getAccountNumberByPlayerName(name)
    if accountId == 0 then
        return false
    end

    local resultId = db.storeQuery("SELECT 1 FROM `account_bans` WHERE `account_id` = " .. accountId)
    if resultId ~= false then
        result.free(resultId)
        return false
    end

    local timeNow = os.time()
    db:query("INSERT INTO `account_bans` (`account_id`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" ..
            accountId .. ", " .. db.escapeString(reason) .. ", " .. timeNow .. ", " .. timeNow + banTime .. ", " .. player:getGuid() .. ")")

    local target = Player(name)
    if target ~= nil then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " has been banned.")
        target:remove()
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been banned.")
    end
end