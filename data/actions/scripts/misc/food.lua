local foods = {
	[3250] = "Crunch.", -- the carrot of doom
	[3577] = "Munch.", -- meat
	[3578] = "Munch.", -- fish
	[3579] = "Mmmm.", -- salmon
	[3580] = "Munch.", -- fish
	[3581] = "Gulp.", -- shrimp
	[3582] = "Chomp.", -- ham
	[3583] = "Chomp.", -- dragon ham
	[3584] = "Yum.", -- pear
	[3585] = "Yum.", -- red apple
	[3586] = "Yum.", -- orange
	[3587] = "Yum.", -- banana
	[3588] = "Yum.", -- blueberry
	[3589] = "Slurp.", -- coconut
	[3590] = "Yum.", -- cherry
	[3591] = "Yum.", -- strawberry
	[3592] = "Yum.", -- grapes
	[3593] = "Yum.", -- melon
	[3594] = "Munch.", -- pumpkin
	[3595] = "Crunch.", -- carrot
	[3596] = "Munch.", -- tomato
	[3597] = "Crunch.", -- corncob
	[3598] = "Crunch.", -- cookie
	[3599] = "Munch.", -- candy cane
	[3600] = "Crunch.", -- bread
	[3601] = "Crunch.", -- roll
	[3602] = "Crunch.", -- brown bread
	[3606] = "Gulp.", -- egg
	[3607] = "Smack.", -- cheese
	[3723] = "Munch.", -- white mushroom
	[3724] = "Munch.", -- red mushroom
	[3725] = "Munch.", -- brown mushroom
	[3726] = "Munch.", -- orange mushroom
	[3727] = "Munch.", -- wood mushroom
	[3728] = "Munch.", -- dark mushroom
	[3729] = "Munch.", -- some mushrooms
	[3730] = "Munch.", -- some mushrooms
	[3731] = "Munch.", -- fire mushroom
	[3732] = "Munch.", -- green mushroom
	[5096] = "Yum.", -- mango
	[5678] = "Gulp.", -- tortoise egg
	[6125] = "Gulp.", -- tortoise egg from Nargor
	[6277] = "Mmmm.", -- cake
	[6278] = "Mmmm.", -- cake
	[6392] = "Mmmm.", -- valentine's cake
	[6393] = "Mmmm.", -- cream cake
	[6500] = "Mmmm.", -- gingerbreadman
	[6541] = "Gulp.", -- coloured egg
	[6542] = "Gulp.", -- coloured egg
	[6543] = "Gulp.", -- coloured egg
	[6544] = "Gulp.", -- coloured egg
	[6545] = "Gulp.", -- coloured egg
	[6569] = "Mmmm.", -- candy
	[6574] = "Mmmm.", -- bar of chocolate
}

function onUse(player, item, fromPosition, target, toPosition)
	local itemType = ItemType(item:getId())
	local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition and math.floor(condition:getTicks() / 1000 + (itemType:getNutrition() * 12)) >= 1200 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are full.")
	else
		player:feed(itemType:getNutrition() * 12)
		item:remove(1)
		
		if configManager.getNumber(configKeys.CLIENT_VERSION) >= 790 then
			player:say(foods[item:getId()] or "Munch.", TALKTYPE_MONSTER_SAY)
		end
	end
	
	return true
end
