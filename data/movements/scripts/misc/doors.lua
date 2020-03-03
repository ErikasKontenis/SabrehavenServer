local verticalDoors = {
	[1643] = 1642,
	[1647] = 1646,
	[1661] = 1660,
	[1665] = 1664,
	[1675] = 1674, 
	[1679] = 1678, 
	[1697] = 1696, 
	[1699] = 1698,
	[5112] = 5111,
	[5114] = 5113,
	[5130] = 5129,
	[5132] = 5131,
	[5288] = 5287,
	[5292] = 5291,
	[5748] = 5749,
	[6202] = 6201,
	[6206] = 6205,
	[6259] = 6258,
	[6263] = 6262,
}

local horizontalDoors = {
	[1645] = 1644, 
	[1649] = 1648, 
	[1663] = 1662,
	[1667] = 1666, 
	[1677] = 1676, 
	[1681] = 1680,
	[1688] = 1687,
	[1690] = 1689,
	[5103] = 5102,
	[5105] = 5104,
	[5121] = 5120,
	[5123] = 5122,
	[5290] = 5289,
	[5294] = 5293,
	[5746] = 5745,
	[6204] = 6203,
	[6208] = 6207,
	[6261] = 6260,
	[6265] = 6264,
}

function onStepOut(creature, item, fromPosition, toPosition)
	local door = verticalDoors[item:getId()]
	if door then
		doRelocate(item:getPosition(), item:getPosition():moveRel(1, 0, 0))
		item:transform(door)
		item:decay()
		return true
	end
	
	door = horizontalDoors[item:getId()]
	if door then
		doRelocate(item:getPosition(), item:getPosition():moveRel(0, 1, 0))
		item:transform(door)
		item:decay()
		return true
	end
end