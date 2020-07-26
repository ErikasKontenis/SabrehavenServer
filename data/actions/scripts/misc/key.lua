local closedDoors = {
	[1628] = 1630,
	[1629] = 1628,
	[1631] = 1633,
	[1632] = 1631,
	[1650] = 1652,
	[1651] = 1650,
	[1653] = 1655,
	[1654] = 1653,
	[1668] = 1670,
	[1669] = 1668,
	[1671] = 1673,
	[1672] = 1671,
	[1682] = 1684,
	[1683] = 1682,
	[1691] = 1693,
	[1692] = 1691,
	[5097] = 5099,
	[5098] = 5097,
	[5106] = 5108,
	[5107] = 5106,
	[5115] = 5117,
	[5116] = 5115,
	[5124] = 5126,
	[5125] = 5124,
	[5133] = 5135,
	[5134] = 5133,
	[5136] = 5138,
	[5137] = 5136,
	[5139] = 5141,
	[5140] = 5139,
	[5142] = 5144,
	[5143] = 5142,
	[5277] = 5279,
	[5278] = 5277,
	[5280] = 5282,
	[5281] = 5280,
	[5732] = 5734,
	[5733] = 5732,
	[5735] = 5737,
	[5736] = 5735,
	[6191] = 6193,
	[6192] = 6191,
	[6194] = 6196,
	[6195] = 6194,
	[6248] = 6250,
	[6249] = 6248,
	[6251] = 6253,
	[6252] = 6251,
}

local openDoors = {
	[1630] = 1628,
	[1633] = 1631,
	[1652] = 1650,
	[1655] = 1653,
	[1670] = 1668,
	[1673] = 1671,
	[1684] = 1682,
	[1693] = 1691,
	[5099] = 5097,
	[5108] = 5106,
	[5117] = 5115,
	[5126] = 5124,
	[5135] = 5133,
	[5138] = 5136,
	[5141] = 5139,
	[5144] = 5142,
	[5279] = 5277,
	[5282] = 5280,
	[5734] = 5732,
	[5737] = 5735,
	[6193] = 6191,
	[6196] = 6194,
	[6250] = 6248,
	[6253] = 6251,
}

function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	local door = closedDoors[target:getId()]
	if not door then
		door = openDoors[target:getId()]
	end
	
	if not door then
		return false
	end
	
	local keyNumber = item:getAttribute(ITEM_ATTRIBUTE_KEYNUMBER)
	local keyHoleNumber = target:getAttribute(ITEM_ATTRIBUTE_KEYHOLENUMBER)
	
	if keyHoleNumber == 0 or keyNumber ~= keyHoleNumber then
		player:sendCancelMessage("The key does not match.")
		return true
	end
	
	target:transform(door)
	target:decay()
	return true
end
