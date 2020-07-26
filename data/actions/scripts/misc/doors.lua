local lockedDoors = {
	1628, 1631, 1650, 1653, 1668, 1671, 1682, 1691, 5006, 5007, 5097, 5106, 5115, 5124, 5133, 5136, 5139, 5142, 5277, 5280, 5732, 5735, 6191, 6194, 6248, 6251
}

local closedNormalDoors = {
	[1629] = 1630,
	[1632] = 1633,
	[1638] = 1639,
	[1640] = 1641,
	[1651] = 1652,
	[1654] = 1655,
	[1656] = 1657,
	[1658] = 1659,
	[1669] = 1670,
	[1672] = 1673,
	[1683] = 1684,
	[1685] = 1686,
	[1692] = 1693,
	[1694] = 1695,
	[4912] = 4911,
	[4913] = 4914,
	[5082] = 5083,
	[5084] = 5085,
	[2177] = 2178,
	[2179] = 2180,
	[5098] = 5099,
	[5100] = 5101,
	[5107] = 5108,
	[5109] = 5110,
	[5116] = 5117,
	[5118] = 5119,
	[5125] = 5126,
	[5127] = 5128,
	[5134] = 5135,
	[5137] = 5138,
	[5140] = 5141,
	[5143] = 5144,
	[5278] = 5279,
	[5281] = 5282,
	[5283] = 5284,
	[5285] = 5286,
	[5514] = 5515,
	[5516] = 5517,
	[5733] = 5734,
	[5736] = 5737,
	[6192] = 6193,
	[6195] = 6196,
	[6197] = 6198,
	[6199] = 6200,
	[6249] = 6250,
	[6252] = 6253,
	[6254] = 6255,
	[6256] = 6257,
}

local openVerticalDoors = {
	[1630] = 1629,
	[1639] = 1638,
	[1643] = 1642,
	[1647] = 1646,
	[1652] = 1651,
	[1657] = 1656,
	[1661] = 1660,
	[1665] = 1664,
	[1670] = 1669,
	[1675] = 1674,
	[1679] = 1678,
	[1693] = 1692,
	[1695] = 1694,
	[1697] = 1696,
	[1699] = 1698,
	[4914] = 4913,
	[5083] = 5082,
	[2178] = 2177,
	[5108] = 5107,
	[5110] = 5109,
	[5112] = 5111,
	[5114] = 5113,
	[5126] = 5125,
	[5128] = 5127,
	[5130] = 5129,
	[5132] = 5131,
	[5141] = 5140,
	[5144] = 5143,
	[5282] = 5281,
	[5284] = 5283,
	[5288] = 5287,
	[5292] = 5291,
	[5515] = 5514,
	[5737] = 5736,
	[5748] = 5749,
	[6193] = 6192,
	[6198] = 6197,
	[6202] = 6201,
	[6206] = 6205,
	[6250] = 6249,
	[6255] = 6254,
	[6259] = 6258,
	[6263] = 6262,
}

local openHorizontalDoors = {
	[1633] = 1632,
	[1641] = 1640,
	[1645] = 1644,
	[1649] = 1648,
	[1655] = 1654,
	[1659] = 1658,
	[1663] = 1662,
	[1667] = 1666,
	[1673] = 1672,
	[1677] = 1676,
	[1681] = 1680,
	[1684] = 1683,
	[1686] = 1685,
	[1688] = 1687,
	[1690] = 1689,
	[4911] = 4912,
	[5085] = 5084,
	[2180] = 2179,
	[5099] = 5098,
	[5101] = 5100,
	[5103] = 5102,
	[5105] = 5104,
	[5117] = 5116,
	[5119] = 5118,
	[5121] = 5120,
	[5123] = 5122,
	[5135] = 5134,
	[5138] = 5137,
	[5279] = 5278,
	[5286] = 5285,
	[5290] = 5289,
	[5294] = 5293,
	[5517] = 5516,
	[5734] = 5733,
	[5746] = 5745,
	[6196] = 6195,
	[6200] = 6199,
	[6204] = 6203,
	[6208] = 6207,
	[6253] = 6252,
	[6257] = 6256,
	[6261] = 6260,
	[6265] = 6264,
}

local levelDoors = {
	[1646] = 1647,
	[1648] = 1649,
	[1664] = 1665,
	[1666] = 1667,
	[1678] = 1679,
	[1680] = 1681,
	[1687] = 1688,
	[1696] = 1697,
	[5102] = 5103,
	[5111] = 5112,
	[5120] = 5121,
	[5129] = 5130,
	[5291] = 5292,
	[5293] = 5294,
	[6205] = 6206,
	[6207] = 6208,
	[6262] = 6263,
	[6264] = 6265,
}

local questDoors = {
	[1642] = 1643,
	[1644] = 1645,
	[1660] = 1661,
	[1662] = 1663,
	[1674] = 1675,
	[1676] = 1677,
	[1689] = 1690,
	[1698] = 1699,
	[5104] = 5105,
	[5113] = 5114,
	[5122] = 5123,
	[5131] = 5132,
	[5287] = 5288,
	[5289] = 5290,
	[5745] = 5746,
	[5749] = 5748,
	[6201] = 6202,
	[6203] = 6204,
	[6258] = 6259,
	[6260] = 6261,
}

local passthrough = {
	[2334] = 2335,
	[2335] = 2334,
	[2336] = 2337,
	[2337] = 2336,
	[2338] = 2339,
	[2339] = 2338,
	[2340] = 2341,
	[2341] = 2340,
}

function onUse(player, item, fromPosition, target, toPosition)
	if table.contains(lockedDoors, item:getId()) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It is locked.")
		return true
	end
	
	local door = closedNormalDoors[item:getId()]
	if door then
		item:transform(door, 1)
		item:decay()
		return true
	end
	
	door = openVerticalDoors[item:getId()]
	if door then
		local doorCreature = Tile(item:getPosition()):getTopCreature()
		if doorCreature then
			doorCreature:teleportTo(item:getPosition():moveRel(1, 0, 0), true)
		end
		item:transform(door, 1)
		item:decay()
		return true
	end
	
	door = openHorizontalDoors[item:getId()]
	if door then
		local doorCreature = Tile(item:getPosition()):getTopCreature()
		if doorCreature then
			doorCreature:teleportTo(item:getPosition():moveRel(0, 1, 0), true)
		end
		item:transform(door, 1)
		item:decay()
		return true
	end
	
	door = levelDoors[item:getId()]
	if door then
		if player:getLevel() < item:getAttribute(ITEM_ATTRIBUTE_DOORLEVEL) then
			player:sendTextMessage(MESSAGE_INFO_DESCR, item:getType():getDescription() .. ".")
			return true
		end
		
		player:teleportTo(item:getPosition(), true)
		item:transform(door, 1)
		item:decay()
		return true
	end
	
	door = questDoors[item:getId()]
	if door then
		local questNumber = item:getAttribute(ITEM_ATTRIBUTE_DOORQUESTNUMBER)
		local questValue = item:getAttribute(ITEM_ATTRIBUTE_DOORQUESTVALUE)
		if questNumber > 0 then
			if player:getStorageValue(questNumber) ~= questValue then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "The door seems to be sealed against unwanted intruders.")
				return true
			end
		end
		
		player:teleportTo(item:getPosition(), true)
		item:transform(door, 1)
		item:decay()
		return true
	end
	
	door = passthrough[item:getId()]
	if door then
		item:transform(door, 1)
		item:decay()
		return true
	end
	return true
end
