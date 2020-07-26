function Container.isContainer(self)
	return true
end

function Container.isItem(self)
	return true
end

function Container.isMonster(self)
	return false
end

function Container.isCreature(self)
	return false
end

function Container.isPlayer(self)
	return false
end

function Container.isTeleport(self)
	return false
end

function Container.isTile(self)
	return false
end

function Container.getItemsById(self, itemId)
	local list = {}
	for index = 0, (self:getSize() - 1) do
		local item = self:getItem(index)
		if item then
			if item:isContainer() then
				local rlist = item:getItemsById(itemId)
				if type(rlist) == 'table' then
					for _, v in pairs(rlist) do
						table.insert(list, v)
					end
				end
			else
				if item:getId() == itemId then
					table.insert(list, item)
				end
			end
		end
	end
	return list
end