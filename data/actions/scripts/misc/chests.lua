function onUse(player, item, fromPosition, target, toPosition)
	local chestQuestNumber = item:getAttribute(ITEM_ATTRIBUTE_CHESTQUESTNUMBER)
	
	if chestQuestNumber == 0 then
		return false
	end
	
	if player:getStorageValue(chestQuestNumber) > 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The " .. item:getName() .. " is empty.")
		return true
	end
	
	local playerCapacity = player:getFreeCapacity()

	if item:getSize() <= 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty. This is a bug, report it to a gamemaster.")
		return true
	end
	
	local reward = item:getItem(0)
	local stackable = reward:getType():isStackable()
	local rewardName = reward:getName()
	local rewardWeight = reward:getWeight()

	if stackable then
		if reward:getCount() > 1 then
			rewardName = reward:getCount() .. " " .. reward:getPluralName()
		else
			rewardName = reward:getName()
		end
	end
	
	if reward:getArticle():len() > 0 and reward:getCount() <= 1 then
		rewardName = reward:getArticle() .. " " .. rewardName
	end
	
	if rewardWeight > playerCapacity and not getPlayerFlagValue(player, layerFlag_HasInfiniteCapacity) then
		local term = "it is"
		if stackable and reward:getCount() > 1 then
			term = "they are"
		end
		
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have found %s. Weighing %d.%02d oz %s too heavy.", rewardName, rewardWeight / 100, rewardWeight % 100, term))
		return true
	end
	
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found " .. rewardName .. ".")
	
	local attackAttribute = math.random(-2, 5)
	local rewardClone = reward:clone()
	if rewardClone:getType():getAttack() > 0 then
		rewardClone:setAttribute(ITEM_ATTRIBUTE_ATTACK, rewardClone:getType():getAttack() + attackAttribute)
		local description = rewardClone:hasAttribute(ITEM_ATTRIBUTE_DESCRIPTION) and rewardClone:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or rewardClone:getType():getDescription()
		if description ~= nil and description ~= '' then
			description = description .. ". "
		end
		
		if attackAttribute == 5 then
			rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with perfect attack.")
		else
			if attackAttribute ~= 0 then
				rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with " .. attackAttribute .. " attack.")
			end
		end
	end
	
	local defenseAttribute = math.random(-2, 5)
	if rewardClone:getType():getDefense() > 0 then
		rewardClone:setAttribute(ITEM_ATTRIBUTE_DEFENSE, rewardClone:getType():getDefense() + defenseAttribute)
		local description = rewardClone:hasAttribute(ITEM_ATTRIBUTE_DESCRIPTION) and rewardClone:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or rewardClone:getType():getDescription()
		
		if rewardClone:getType():getAttack() > 0 and attackAttribute ~= 0 then
			if defenseAttribute == 5 then
				rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. " Enchanted with perfect defense.")
			else
				if defenseAttribute ~= 0 then
					rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. " Enchanted with " .. defenseAttribute .. " defense.")
				end
			end
		else
			if description ~= nil and description ~= '' then
				description = description .. ". "
			end
			
			if defenseAttribute == 5 then
				rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with perfect defense.")
			else
				if defenseAttribute ~= 0 then
					rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with " .. defenseAttribute .. " defense.")
				end
			end
		end
	end
	
	local armorAttribute = math.random(-1, 2)
	if rewardClone:getType():getArmor() > 0 then
		rewardClone:setAttribute(ITEM_ATTRIBUTE_ARMOR, rewardClone:getType():getArmor() + armorAttribute)
		local description = rewardClone:hasAttribute(ITEM_ATTRIBUTE_DESCRIPTION) and rewardClone:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or rewardClone:getType():getDescription()
		if description ~= nil and description ~= '' then
			description = description .. ". "
		end
		
		if armorAttribute == 2 then
			rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with perfect armor protection.")
		else
			if armorAttribute ~= 0 then
				rewardClone:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description .. "Enchanted with " .. armorAttribute .. " armor protection.")
			end
		end
	end
	
	player:addItemEx(rewardClone, true)
	player:setStorageValue(chestQuestNumber, 1)
	return true
end
