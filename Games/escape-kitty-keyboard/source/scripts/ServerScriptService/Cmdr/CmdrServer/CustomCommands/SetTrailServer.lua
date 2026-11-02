local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local EventsConfig = require(ReplicatedStorage:WaitForChild("EventsConfig"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

-- Build a list of all valid trail keys
local function getAllTrailKeys()
	local keys = {}
	for key in pairs(Config.TRAILS or {}) do
		table.insert(keys, key)
	end
	for _, trail in ipairs(EventsConfig.Trails or {}) do
		table.insert(keys, trail.Key)
	end
	table.sort(keys)
	return keys
end

-- Check if a trail key is valid
local function isValidTrail(trailKey)
	if trailKey == "None" then return true end
	if Config.TRAILS and Config.TRAILS[trailKey] then return true end
	for _, trail in ipairs(EventsConfig.Trails or {}) do
		if trail.Key == trailKey then return true end
	end
	return false
end

return function(context, target, trailName, equip)
	-- Handle 'list' to show all available trails
	if string.lower(trailName) == "list" then
		local keys = getAllTrailKeys()
		return "Available trails: " .. table.concat(keys, ", ")
	end
	
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	if not isValidTrail(trailName) then
		local keys = getAllTrailKeys()
		return string.format("Invalid trail '%s'. Available: %s", trailName, table.concat(keys, ", "))
	end
	
	-- Add to owned trails if not already owned
	local alreadyOwned = false
	if trailName ~= "None" then
		for _, owned in ipairs(data.OwnedTrails or {}) do
			if owned == trailName then
				alreadyOwned = true
				break
			end
		end
		if not alreadyOwned then
			table.insert(data.OwnedTrails, trailName)
		end
	end
	
	-- Equip if requested (default true)
	local shouldEquip = equip ~= false
	if shouldEquip then
		data.EquippedTrail = trailName
		if target.Character then
			target.Character:SetAttribute("EquippedTrail", trailName)
		end
	end
	
	-- Update client UI
	local update = { OwnedTrails = data.OwnedTrails }
	if shouldEquip then
		update.EquippedTrail = trailName
	end
	UpdateUI:FireClient(target, update)
	
	local msg = string.format("Gave trail '%s' to %s%s.", trailName, target.Name, shouldEquip and " (equipped)" or "")
	if alreadyOwned then
		msg = string.format("%s already owns '%s'. %s", target.Name, trailName, shouldEquip and "Equipped it." or "No changes.")
	end
	return msg
end