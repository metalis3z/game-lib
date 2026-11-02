-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Core/TableUtil.lua  (57 lines)
-- What it does: DeepCopy (keys too), ShallowCopy, ArrayToSet, SetToArray (sorted) and SanitizeKey.

local TableUtil = {}

function TableUtil.DeepCopy(value)
	if type(value) ~= "table" then
		return value
	end

	local clone = {}
	for key, child in pairs(value) do
		clone[TableUtil.DeepCopy(key)] = TableUtil.DeepCopy(child)
	end
	return clone
end

function TableUtil.ShallowCopy(source)
	local copy = {}
	if type(source) == "table" then
		for key, value in pairs(source) do
			copy[key] = value
		end
	end
	return copy
end

function TableUtil.ArrayToSet(values)
	local set = {}
	if type(values) == "table" then
		for _, value in ipairs(values) do
			set[value] = true
		end
	end
	return set
end

function TableUtil.SetToArray(setTable)
	local values = {}
	if type(setTable) == "table" then
		for key, value in pairs(setTable) do
			if value == true then
				table.insert(values, key)
			end
		end
		table.sort(values, function(left, right)
			return tostring(left) < tostring(right)
		end)
	end
	return values
end

function TableUtil.SanitizeKey(name)
	if type(name) ~= "string" then
		return ""
	end
	return (name:gsub("%s+", ""))
end

return TableUtil
