local distillingMachines = {
	[5468] = 5512,
	[5469] = 5513
}

function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	local machine = distillingMachines[target:getId()]
	if machine then
		target:transform(machine, 1)
		target:decay()
		item:remove(1)
		return true
	end
		
	return false
end
