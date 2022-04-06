function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local split = param:split(",")
	local target = Player(split[1])
	if target == nil then
		player:sendCancelMessage("Player not found.")
		return false
	end

	if target:getGroup():getAccess() then
		player:sendCancelMessage("You cannot impersonate this player.")
		return false
	end
	
	target:say(split[2], TALKTYPE_SAY)
	return false
end
