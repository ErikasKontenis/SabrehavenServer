dofile('data/lib/lib.lua')

function getDistanceBetween(firstPosition, secondPosition)
	local xDif = math.abs(firstPosition.x - secondPosition.x)
	local yDif = math.abs(firstPosition.y - secondPosition.y)
	local posDif = math.max(xDif, yDif)
	if firstPosition.z ~= secondPosition.z then
		posDif = posDif + 15
	end
	return posDif
end

function getFormattedWorldTime()
	local worldTime = getWorldTime()
	local hours = math.floor(worldTime / 60)

	local minutes = worldTime % 60
	if minutes < 10 then
		minutes = '0' .. minutes
	end
	return hours .. ':' .. minutes
end

string.split = function(str, sep)
	local res = {}
	for v in str:gmatch("([^" .. sep .. "]+)") do
		res[#res + 1] = v
	end
	return res
end

string.trim = function(str)
	return str:match'^()%s*$' and '' or str:match'^%s*(.*%S)'
end

table.contains = function(array, value)
	for _, targetColumn in pairs(array) do
		if targetColumn == value then
			return true
		end
	end
	return false
end

function isNumber(str)
	return tonumber(str) ~= nil
end

if not nextUseStaminaTime then
	nextUseStaminaTime = {}
end

function isInArray(array, value, isCaseSensitive)
    local compareLowerCase = false
    if value ~= nil and type(value) == "string" and not isCaseSensitive then
        value = string.lower(value)
        compareLowerCase = true
    end
    if array == nil or value == nil then
        return (array == value), nil
    end
    local t = type(array)
    if t ~= "table" then
        if compareLowerCase and t == "string" then
            return (string.lower(array) == string.lower(value)), nil
        else
            return (array == value), nil
        end
    end
    for k,v in pairs(array) do
        local newV
        if compareLowerCase and type(v) == "string" then
            newV = string.lower(v)
        else
            newV = v
        end
        if newV == value then
            return true, k
        end
    end
    return false
end