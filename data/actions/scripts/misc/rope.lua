local ropeSpots = {
	386, 421
}

local holeSpots = {
	293, 294, 369, 370, 385, 394, 411, 412,
	421, 432, 433, 435, 482, 5081, 483, 594,
	595, 607, 609, 610, 615, 1066, 1067, 1080
}

local pools = {2886, 2887, 2888, 2889, 2890, 2891, 2895, 2896, 2897, 2898, 2899, 2900}

-- Rope for 7.4 protocol.
function onUse(cid, item, frompos, item2, topos)
    local newPos = {x = topos.x, y = topos.y, z = topos.z, stackpos = 0}
    local groundItem = getThingfromPos(newPos)
    local blockingItem = getThingfromPos({x = topos.x, y = topos.y, z = topos.z, stackpos = 255})
    if table.contains(ropeSpots, groundItem.itemid) then
        newPos.y = newPos.y + 1
        newPos.z = newPos.z - 1
        if((blockingItem.itemid > 0 and not isInArray(pools, blockingItem.itemid)) or isCreature(blockingItem.uid)) then
            doPlayerSendCancel(cid, "You cannot use this object.")
        else
            doTeleportThing(cid, newPos)
        end
    elseif table.contains(holeSpots, groundItem.itemid) then
        newPos.y = newPos.y + 1
        local downPos = {x = topos.x, y = topos.y, z = topos.z + 1, stackpos = 255}
        local downItem = getThingfromPos(downPos)
        if(downItem.itemid > 0) then
            doTeleportThing(downItem.uid, newPos)
        else
            doPlayerSendCancel(cid, "You cannot use this object.")
        end
    end
    return true
end