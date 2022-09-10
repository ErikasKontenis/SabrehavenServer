-- BETA VERSION, net tested yet
-- Instruction: 
-- creaturescripts.xml      <event type="extendedopcode" name="Shop" script="shop.lua" />
-- and in login.lua         player:registerEvent("Shop")
-- create sql table shop_history
-- set variables
-- set up function init(), add there items and categories, follow examples
-- set up callbacks at the bottom to add player item/outfit/whatever you want

local SHOP_EXTENDED_OPCODE = 201
local SHOP_OFFERS = {}
local SHOP_CALLBACKS = {}
local SHOP_CATEGORIES = nil
local SHOP_BUY_URL = "http://otland.net" -- can be empty
local SHOP_AD = { -- can be nil
	image = "https://s3.envato.com/files/62273611/PNG%20Blue/Banner%20blue%20468x60.png",
	url = "http://otclient.ovh",
	text = ""
}
local MAX_PACKET_SIZE = 50000

--[[ SQL TABLE
CREATE TABLE `shop_history` (
  `id` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `player` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `title` varchar(100) NOT NULL,
  `cost` int(11) NOT NULL,
  `details` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `shop_history`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `shop_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
]]--

function init()
	--  print(json.encode(g_game.getLocalPlayer():getOutfit())) -- in console in otclient, will print current outfit and mount
	
	SHOP_CATEGORIES = {}
	
	local category1 = addCategory({
		type="item",
		item=ItemType(6561):getId(),
		count=1,
		name="Items"
	})
	local category2 = addCategory({
		type="outfit",
		name="Outfits",
		outfit={
			mount=0,
			feet=0,
			legs=0,
			body=0,
			type=136,
			auxType=0,
			addons=0,
			head=0,
			rotating=false
		}
	})
	local category3 = addCategory({
		type="outfit",
		name="Mounts",
		outfit={
			mount=0,
			feet=0,
			legs=0,
			body=0,
			type=368,
			auxType=0,
			addons=0,
			head=0,
			rotating=false
		}
	})
	local category4 = addCategory({
		type="item",
		item=ItemType(5919):getId(),
		count=1,
		name="Addon Items"
	})
	local category5 = addCategory({
		type="item",
		item=ItemType(4835):getId(),
		count=1,
		name="Quest Items"
	})
	local category6 = addCategory({
		type="item",
		item=ItemType(3734):getId(),
		count=1,
		name="Decorations"
	})
	-- local category4 = addCategory({
	-- type="image",
	-- image="/data/images/game/states/electrified.png",
	-- name="Category with local image"
	-- })
	
	
	category1.addItem(50, 6561, 1, "Ceremonial Ankh", "gives you all blessings")
	category1.addItem(20, 5908, 1, "Obsidian Knife", "")
	category1.addItem(200, 5797, 1, "Dice", "")
	category1.addItem(100, 6549, 1, "Green Djinn Access", "The magical powder will bless you with the power to convince the green djinns")
	category1.addItem(100, 6551, 1, "Blue Djinn Access", "The magical powder will bless you with the power to convince the blue djinns")
	category1.addItem(100, 3252, 1, "Postman Access", "The magical horn will grant you the trustworthy postman rank")
	
	category2.addOutfit(150, {
		mount=0,
		feet=0,
		legs=0,
		body=0,
		type=162,
		auxType=0,
		addons=0,
		head=0,
		rotating=true
	}, "Monk", "")
	
	category3.addOutfit(75, {
		mount=1,
		feet=0,
		legs=0,
		body=0,
		type=368,
		auxType=0,
		addons=0,
		head=0,
		rotating=true
	}, "Widow Queen", "")
	
	category4.addItem(3, 5902, 10, "10x Honeycomb", "Some people swear it makes an excellent glue")
	category4.addItem(3, 5898, 5, "5x Beholder's eye", "")
	category4.addItem(3, 3077, 1, "Ankh", "")
	category4.addItem(3, 5894, 10, "10x Bat Wing", "")
	category4.addItem(3, 5899, 10, "10x Turtle Shell", "")
	category4.addItem(4, 5925, 10, "10x Hardened Bone", "")
	category4.addItem(4, 5897, 10, "10x Wolf Paw", "")
	category4.addItem(4, 5896, 10, "10x Bear Paw", "")
	category4.addItem(4, 5890, 20, "20x Chicken Feather", "")
	category4.addItem(5, 5920, 5, "5x Green Dragon Scale", "")
	category4.addItem(5, 5921, 10, "10x Heaven Blossom", "")
	category4.addItem(5, 5881, 10, "10x Lizard Scale", "")
	category4.addItem(5, 5905, 10, "10x Vampire Dust", "")
	category4.addItem(5, 5883, 10, "10x Ape Fur", "")
	category4.addItem(5, 5893, 5, "5x Perfect Behemoth Fang", "Collectors all around the world crave for this item")
	category4.addItem(6, 6126, 25, "25x Peg Leg", "It belonged once to a pirate")
	category4.addItem(6, 6097, 25, "25x Hook", "It belonged once to a pirate")
	category4.addItem(6, 5879, 10, "10x Spider Silk", "")
	category4.addItem(6, 5930, 1, "Behemoth Claw", "")
	category4.addItem(6, 6098, 25, "25x Eye Patch", "It belonged once to a pirate")
	category4.addItem(6, 5922, 10, "10x Holy Orchid", "")
	category4.addItem(7, 5895, 10, "10x Fish Fin", "It once belonged to a mighty creature of the deep")
	category4.addItem(7, 5906, 2, "2x Demon Dust", "It reeks of hatred and malice")
	category4.addItem(7, 5882, 5, "5x Red Dragon Scale", "")
	category4.addItem(7, 5909, 10, "10x White Piece of Cloth", "")
	category4.addItem(7, 5910, 10, "10x Green Piece of Cloth", "")
	category4.addItem(7, 5911, 10, "10x Red Piece of Cloth", "")
	category4.addItem(7, 5912, 10, "10x Blue Piece of Cloth", "")
	category4.addItem(7, 5913, 10, "10x Brown Piece of Cloth", "")
	category4.addItem(7, 5914, 10, "10x Yellow Piece of Cloth", "")
	category4.addItem(7, 5876, 10, "10x Lizard Leather", "")
	category4.addItem(7, 5880, 10, "10x Iron Ore", "")
	category4.addItem(7, 5948, 10, "10x Red Dragon Leather", "")
	category4.addItem(25, 5875, 1, "Sniper Gloves", "They are the pride of the paladin guild")
	category4.addItem(50, 6099, 1, "Brutus Bloodbeard's Hat", "")
	category4.addItem(50, 6100, 1, "The Lethal Lissy's Shirt", "")
	category4.addItem(50, 6102, 1, "Deadeye Devious' Eye Patch", "")
	category4.addItem(50, 6101, 1, "Ron the Ripper's Sabre", "")
	category4.addItem(50, 5945, 1, "Coral Comb", "It once belonged to a mermaid")
	category4.addItem(150, 5014, 1, "Mandrake", "")
	category4.addItem(150, 5809, 1, "Soul Stone", "It contains the essence of countless tormented souls")
	category4.addItem(150, 5804, 1, "Nose Ring", "It was the favourite trinket of the famous Horned Fox")
	category4.addItem(150, 5919, 1, "Dragon Claw", "It is the claw of Demodras")
	
	category5.addItem(30, 4835, 1, "Snake Destroyer", "")
	category5.addItem(30, 3231, 1, "Gemmed Lamp", "It is Fa'hradin's enchanted lamp")
	category5.addItem(30, 7924, 1, "The Ring of The Count", "")
	category5.addItem(30, 4838, 1, "Strange Powder", "")
	category5.addItem(30, 4836, 1, "Spectral Dress", "")
	category5.addItem(30, 4829, 1, "Witches' Cap Spot", "")
	category5.addItem(30, 4846, 1, "Wrinkled Parchment", "It is covered with strange numbers")
	category5.addItem(30, 5929, 1, "Goldfish Bowl", "")
	category5.addItem(30, 6105, 1, "Striker's Favourite Pillow", "")
	category5.addItem(30, 4832, 1, "Giant Ape's Hair", "")
	category5.addItem(30, 3233, 1, "Tear of Daraman", "")
	category5.addItem(30, 4847, 1, "Funeral Urn", "It contains the ashes of a lizard high priest")
	category5.addItem(30, 3217, 1, "Letterbag", "This bag is nearly bursting from all the letters inside")
	category5.addItem(30, 3218, 1, "Kevin's Present", "")
	category5.addItem(30, 3216, 1, "Kevin's Bill", "This is a bill for an expensive magicians hat and several rabbits")
	category5.addItem(30, 3220, 1, "Letter to Markwin", "")
	category5.addItem(30, 6108, 1, "Atlas", "It is filled with detailed maps")
	
	category6.addItem(10, 3734, 10, "10x Blood Herb", "")
	category6.addItem(10, 3589, 10, "10x Coconut", "")
	category6.addItem(10, 3249, 1, "Frozen Starlight", "")
	category6.addItem(10, 5080, 1, "Panda Teddy", "")
	category6.addItem(10, 7184, 1, "Baby Seal Doll", "")
	category6.addItem(10, 5791, 1, "Stuffed Dragon", "")
	
	--category4.addImage(10000, "/data/images/game/states/haste.png", "Offer with local image", "another local image\n/data/images/game/states/haste.png")
	--category4.addImage(10000, "http://otclient.ovh/images/freezing.png", "Offer with remote image and custom buy action", "blalasdasd image\nhttp://otclient.ovh/images/freezing.png", customImageBuyAction)
end

function addCategory(data)
  data['offers'] = {}
  table.insert(SHOP_CATEGORIES, data)
  table.insert(SHOP_CALLBACKS, {})
  local index = #SHOP_CATEGORIES
  return {
    addItem = function(cost, itemId, count, title, description, callback)      
      if not callback then
        callback = defaultItemBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost=cost,
        type="item",
        item=ItemType(itemId):getId(), -- displayed
        itemId=itemId,
        count=count,
        title=title,
        description=description
      })
      table.insert(SHOP_CALLBACKS[index], callback)
    end,
    addOutfit = function(cost, outfit, title, description, callback)
      if not callback then
        callback = defaultOutfitBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost=cost,
        type="outfit",
        outfit=outfit,
        title=title,
        description=description
      })    
      table.insert(SHOP_CALLBACKS[index], callback)
    end,
    addImage = function(cost, image, title, description, callback)
      if not callback then
        callback = defaultImageBuyAction
      end
      table.insert(SHOP_CATEGORIES[index]['offers'], {
        cost=cost,
        type="image",
        image=image,
        title=title,
        description=description
      })
      table.insert(SHOP_CALLBACKS[index], callback)
    end
  }
end

function getPoints(player)
  local points = 0
  local resultId = db.storeQuery("SELECT `points` FROM `znote_accounts` WHERE `id` = " .. player:getAccountId())
  if resultId ~= false then
    points = result.getDataInt(resultId, "points")
    result.free(resultId)
  end
  return points
end

function getStatus(player)
  local status = {
    ad = SHOP_AD,
    points = getPoints(player),
    buyUrl = SHOP_BUY_URL
  }
  return status
end

function sendJSON(player, action, data, forceStatus)
  local status = nil
  if not player:getStorageValue(1150001) or player:getStorageValue(1150001) + 10 < os.time() or forceStatus then
      status = getStatus(player)
  end
  player:setStorageValue(1150001, os.time())
  

  local buffer = json.encode({action = action, data = data, status = status})  
  local s = {}
  for i=1, #buffer, MAX_PACKET_SIZE do
     s[#s+1] = buffer:sub(i,i+MAX_PACKET_SIZE - 1)
  end
  local msg = NetworkMessage()
  if #s == 1 then
    msg:addByte(50)
    msg:addByte(SHOP_EXTENDED_OPCODE)
    msg:addString(s[1])
    msg:sendToPlayer(player)
    return  
  end
  -- split message if too big
  msg:addByte(50)
  msg:addByte(SHOP_EXTENDED_OPCODE)
  msg:addString("S" .. s[1])
  msg:sendToPlayer(player)
  for i=2,#s - 1 do
    msg = NetworkMessage()
    msg:addByte(50)
    msg:addByte(SHOP_EXTENDED_OPCODE)
    msg:addString("P" .. s[i])
    msg:sendToPlayer(player)
  end
  msg = NetworkMessage()
  msg:addByte(50)
  msg:addByte(SHOP_EXTENDED_OPCODE)
  msg:addString("E" .. s[#s])
  msg:sendToPlayer(player)
end

function sendMessage(player, title, msg, forceStatus)
  sendJSON(player, "message", {title=title, msg=msg}, forceStatus)
end

function onExtendedOpcode(player, opcode, buffer)
  if opcode ~= SHOP_EXTENDED_OPCODE then
    return false
  end
  local status, json_data = pcall(function() return json.decode(buffer) end)
  if not status then
    return false
  end

  local action = json_data['action']
  local data = json_data['data']
  if not action or not data then
    return false
  end

  if SHOP_CATEGORIES == nil then
    init()    
  end

  if action == 'init' then
    sendJSON(player, "categories", SHOP_CATEGORIES)
  elseif action == 'buy' then
    processBuy(player, data)
  elseif action == "history" then
    sendHistory(player)
  end
  return true
end

function processBuy(player, data)
  local categoryId = tonumber(data["category"])
  local offerId = tonumber(data["offer"])
  local offer = SHOP_CATEGORIES[categoryId]['offers'][offerId]
  local callback = SHOP_CALLBACKS[categoryId][offerId]
  if not offer or not callback or data["title"] ~= offer["title"] or data["cost"] ~= offer["cost"] then
    sendJSON(player, "categories", SHOP_CATEGORIES) -- refresh categories, maybe invalid
    return sendMessage(player, "Error!", "Invalid offer")      
  end
  local points = getPoints(player)
  if not offer['cost'] or offer['cost'] > points or points < 1 then
    return sendMessage(player, "Error!", "You don't have enough points to buy " .. offer['title'] .."!", true)    
  end
  local status = callback(player, offer)
  if status == true then    
    db.query("UPDATE `znote_accounts` set `points` = `points` - " .. offer['cost'] .. " WHERE `id` = " .. player:getAccountId())
    db.asyncQuery("INSERT INTO `shop_history` (`account`, `player`, `date`, `title`, `cost`, `details`) VALUES ('" .. player:getAccountId() .. "', '" .. player:getGuid() .. "', NOW(), " .. db.escapeString(offer['title']) .. ", " .. db.escapeString(offer['cost']) .. ", " .. db.escapeString(json.encode(offer)) .. ")")
    return sendMessage(player, "Success!", "You bought " .. offer['title'] .."!", true)
  end
  if status == nil or status == false then
    status = "Unknown error while buying " .. offer['title']
  end
  sendMessage(player, "Error!", status)
end

function sendHistory(player)
  if player:getStorageValue(1150002) and player:getStorageValue(1150002) + 10 > os.time() then
    return -- min 10s delay
  end
  player:setStorageValue(1150002, os.time())
  
  local history = {}
	local resultId = db.storeQuery("SELECT * FROM `shop_history` WHERE `account` = " .. player:getAccountId() .. " order by `id` DESC")

	if resultId ~= false then
    repeat
      local details = result.getDataString(resultId, "details")
      local status, json_data = pcall(function() return json.decode(details) end)
      if not status then    
        json_data = {
          type = "image",
          title = result.getDataString(resultId, "title"),
          cost = result.getDataInt(resultId, "cost")
        }
      end
      table.insert(history, json_data)
      history[#history]["description"] = "Bought on " .. result.getDataString(resultId, "date") .. " for " .. result.getDataInt(resultId, "cost") .. " points."
    until not result.next(resultId)
    result.free(resultId)
	end
  
  sendJSON(player, "history", history)
end

-- BUY CALLBACKS
-- May be useful: print(json.encode(offer))

function defaultItemBuyAction(player, offer)
  -- todo: check if has capacity
  if player:addItem(offer["itemId"], offer["count"], false) then
    return true
  end
  return "Can't add item! Do you have enough space?"
end

function defaultOutfitBuyAction(player, offer)
  return "default outfit buy action is not implemented"
end

function defaultImageBuyAction(player, offer)
  return "default image buy action is not implemented"
end

function customImageBuyAction(player, offer)
  return "custom image buy action is not implemented. Offer: " .. offer['title']
end