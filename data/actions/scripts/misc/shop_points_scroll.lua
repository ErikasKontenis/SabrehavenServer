local hundredPoints = 6554
local fiftyPoints = 6555

function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == hundredPoints then
		db.query("UPDATE znote_accounts SET points = points + 100 WHERE account_id = ".. player:getAccountId() .."")
	elseif item:getId() == fiftyPoints then
		db.query("UPDATE znote_accounts SET points = points + 50 WHERE account_id = ".. player:getAccountId() .."")
	end
	
	item:getPosition():sendMagicEffect(3)
	item:remove()
	player:save()
	return true
end
