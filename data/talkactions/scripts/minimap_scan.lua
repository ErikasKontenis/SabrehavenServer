local distanceBetweenPositionsX = 8
local distanceBetweenPositionsY = 8
local addEventDelay = 500
local teleportsPerEvent = 1
local maxEventExecutionTime = 2000

local function teleportToClosestPosition(player, x, y, z)
   -- direct to position
   local tile = Tile(x, y, z)

   if not tile or not tile:getGround() or tile:hasFlag(TILESTATE_TELEPORT) or not player:teleportTo(tile:getPosition()) then
      for distance = 1, 3 do
         -- try to find some close tile
         for changeX = -distance, distance, distance do
            for changeY = -distance, distance, distance do
               tile = Tile(x + changeX, y + changeY, z)
               if tile and tile:getGround() and not tile:hasFlag(TILESTATE_TELEPORT) and player:teleportTo(tile:getPosition()) then
                  return true
               end
            end
         end
      end

      return false
   end

   return true
end

local function sendScanProgress(player, minX, maxX, minY, maxY, x, y, z, lastProgress)
   local progress = math.floor(((y - minY + (((x - minX) / (maxX - minX)) * distanceBetweenPositionsY)) / (maxY - minY)) * 100)
   if progress ~= lastProgress then
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Scan progress: ~' .. progress .. '%')
   end

   return progress
end

local function minimapScan(cid, minX, maxX, minY, maxY, x, y, z, lastProgress)
   local player = Player(cid)

   if not player then
      --print('Minimap scan stopped - player logged out', cid, minX, maxX, minY, maxY, x, y, z)
      return
   end

   local scanStartTime = os.mtime()
   local teleportsDone = 0
   while true do
      if scanStartTime + maxEventExecutionTime < os.mtime() then
         lastProgress = sendScanProgress(player, minX, maxX, minY, maxY, x, y, z, lastProgress)
         addEvent(minimapScan, addEventDelay, cid, minX, maxX, minY, maxY, x, y, z, lastProgress)
         break
      end

      x = x + distanceBetweenPositionsX
      if x > maxX then
         x = minX
         y = y + distanceBetweenPositionsY
         if y > maxY then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Scan finished: ' .. os.time())
            --print('Minimap scan complete', player:getName(), minX, maxX, minY, maxY, x, y, z)
            break
         end
      end

      if teleportToClosestPosition(player, x, y, z) then
         teleportsDone = teleportsDone + 1
         lastProgress = sendScanProgress(player, minX, maxX, minY, maxY, x, y, z, lastProgress)

         --print('Minimap scan teleport', player:getName(), minX, maxX, minY, maxY, x, y, z, progress, teleportsDone)
         if teleportsDone == teleportsPerEvent then
            addEvent(minimapScan, addEventDelay, cid, minX, maxX, minY, maxY, x, y, z, progress)
            break
         end
      end
   end
end

local function minimapStart(player, minX, maxX, minY, maxY, x, y, z)
   player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Scan started: ' .. os.time())
   --print('Minimap scan start', player:getName(), minX, maxX, minY, maxY, x, y, z)
   minimapScan(player:getId(), minX, maxX, minY, maxY, minX - 5, minY, z)
end

function onSay(player, words, param)
   if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

   local positions = param:split(',')
   if #positions ~= 5 then
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Command requires 5 parameters: /minimap minX, maxX, minY, maxY, z')
      return false
   end

   for key, position in pairs(positions) do
      local value = tonumber(position)

      if not value then
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Invalid parameter ' .. key .. ': ' .. position)
         return false
      end

      positions[key] = value
   end

   minimapStart(player, positions[1], positions[2], positions[3], positions[4], positions[1] - distanceBetweenPositionsX, positions[3], positions[5])
   return false
end