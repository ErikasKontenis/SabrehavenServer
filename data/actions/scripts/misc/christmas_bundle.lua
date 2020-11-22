function onUse(player, item, fromPosition, target, toPosition, isHotkey)
 
    local bundleTypes = {
        [6506] = { -- red christmas bundle
            6503
        },
        [6507] = { -- blue christmas bundle
            6504
        },
        [6508] = { -- green christmas bundle
            6502
        }
    }

    local common = {
        {6569, 15}, {3598, 20}, {3599, 10}, {3586, 10}, {3585, 5}, 6500, 6501, 6489, 6387
    }
   
    local targetItem = bundleTypes[item.itemid]
    if not targetItem then
        return true
    end
   
    targetItem = common

    -- In case there's going to be more than one unique item per bundle
    for i = 1, #bundleTypes[item.itemid] do
        table.insert(targetItem, bundleTypes[item.itemid][i])
    end
   
    local rewards = {}
    repeat
        local count = 1
        local rand = math.random(#targetItem)
        local gift = targetItem[rand]
        if type(gift) == "table" then
            count = gift[2]
            gift = gift[1]
        end
        rewards[#rewards + 1] = {gift, count}
        table.remove(targetItem, rand)
    until #rewards == 7
 
    for i = 1, #rewards do
        player:addItem(rewards[i][1], rewards[i][2])
    end
    item:remove(1)
    fromPosition:sendMagicEffect(CONST_ME_GIFT_WRAPS)
    return true
end