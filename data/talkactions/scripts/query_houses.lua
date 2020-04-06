function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	local searchItemId = tonumber(param)
	
	for _, house in pairs(Game.getHouses()) do
		for _, tile in pairs(house:getTiles()) do
			for _, item in pairs(tile:getItems()) do
				if item ~= nil then
					local isFound = false
					if item:isContainer() then
						local items = item:getItemsById(searchItemId)
						isFound = #items > 0
					else
						isFound = item:getId() == searchItemId
					end
					
					if isFound then
						local position = item:getPosition()
						player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Item position is: " .. position.x .. ", " .. position.y .. ", " .. position.z .. ".")
					end
				end
			end			
		end
	end
	
	return false
end