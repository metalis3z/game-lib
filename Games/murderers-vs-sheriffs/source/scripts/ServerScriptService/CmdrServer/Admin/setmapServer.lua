local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Sync = require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"))
local MapsFolder = ServerStorage:WaitForChild("Database"):WaitForChild("Maps")

local ForcedMapValue = ServerStorage:FindFirstChild("ForcedMap")
if not ForcedMapValue then
	ForcedMapValue = Instance.new("StringValue")
	ForcedMapValue.Name = "ForcedMap"
	ForcedMapValue.Parent = ServerStorage
end

local function findMap(mapName)
	local lowerMapName = string.lower(mapName)

	for mapKey in pairs(Sync.Maps) do
		if string.lower(mapKey) == lowerMapName then
			return mapKey
		end
	end

	for mapKey in pairs(Sync.Maps) do
		if string.find(string.lower(mapKey), lowerMapName, 1, true) then
			return mapKey
		end
	end
end

local function getMapList()
	local names = {}
	for mapKey in pairs(Sync.Maps) do
		if MapsFolder:FindFirstChild(mapKey) then
			table.insert(names, mapKey)
		end
	end
	table.sort(names)
	return table.concat(names, ", ")
end

return function(context, mapName)
	if typeof(mapName) ~= "string" or not mapName:match("%S") then
		return "Usage: setmap <map name>"
	end

	mapName = mapName:match("^%s*(.-)%s*$")
	local actualMap = findMap(mapName)
	if not actualMap then
		return "Map '" .. mapName .. "' does not exist. Existing maps: " .. getMapList()
	end

	if not MapsFolder:FindFirstChild(actualMap) then
		return "Map '" .. actualMap .. "' exists in Sync.Maps but is missing from ServerStorage.Maps."
	end

	_G.Map = actualMap
	ForcedMapValue.Value = actualMap
	return "Map set to " .. actualMap .. " for the next round."
end