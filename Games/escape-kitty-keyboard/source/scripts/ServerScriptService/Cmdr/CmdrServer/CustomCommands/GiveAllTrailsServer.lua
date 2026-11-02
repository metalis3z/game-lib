local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local EventsConfig = require(ReplicatedStorage:WaitForChild("EventsConfig"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

return function(context, target, equipBest)
	local data = DataHandler.Get(target)
	if not data then
		return "Player data not loaded."
	end
	
	local added = 0
	local ownedSet = {}
	for _, owned in ipairs(data.OwnedTrails or {}) do
		ownedSet[owned] = true
	end
	
	-- Add all trails from Config
	for key in pairs(Config.TRAILS or {}) do
		if not ownedSet[key] then
			table.insert(data.OwnedTrails, key)
			ownedSet[key] = true
			added = added + 1
		end
	end
	
	-- Add all trails from EventsConfig
	for _, trail in ipairs(EventsConfig.Trails or {}) do
		if not ownedSet[trail.Key] then
			table.insert(data.OwnedTrails, trail.Key)
			ownedSet[trail.Key] = true
			added = added + 1
		end
	end
	
	-- Optionally equip the best trail (InfinityTrail = 5,000,000x)
	if equipBest then
		data.EquippedTrail = "InfinityTrail"
		if target.Character then
			target.Character:SetAttribute("EquippedTrail", "InfinityTrail")
		end
	end
	
	-- Update client UI
	local update = { OwnedTrails = data.OwnedTrails }
	if equipBest then
		update.EquippedTrail = "InfinityTrail"
	end
	UpdateUI:FireClient(target, update)
	
	local msg = string.format("Gave %d new trails to %s. Total trails owned: %d.", added, target.Name, #data.OwnedTrails)
	if equipBest then
		msg = msg .. " Equipped InfinityTrail (5,000,000x multiplier)."
	end
	return msg
end