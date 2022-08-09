function postostring(pos)
  return pos.x .. " " .. pos.y .. " " .. pos.z
end

function dirtostring(dir)
  for k,v in pairs(Directions) do
    if v == dir then
      return k
    end
  end
end

function toHighlightedText(text, color)
  local tmpData = {}
  
  for i, part in ipairs(text:split("[")) do
    if i == 1 then
      table.insert(tmpData, part)
      table.insert(tmpData, color)
    else
      for j, part2 in ipairs(part:split("]")) do
        if j == 1 then
		  local text = part2:split(":")
		  if #text == 2 then
			table.insert(tmpData, part2:split(":")[2])
			table.insert(tmpData, part2:split(":")[1])
		   else
			table.insert(tmpData, '[' .. part2 .. ']')
			table.insert(tmpData, color)
		  end
        else
          table.insert(tmpData, part2)
          table.insert(tmpData, color)
        end
      end
    end
  end

  return tmpData
end