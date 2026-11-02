--!strict

local InventoryService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local Sort = Net:RemoteEvent("InventoryService/Sort")

Sort.OnServerEvent:Connect(function(player: Player, toolName: string, toolIndex: number)
	local data = Synchronizer:Get(player)
	if not data then
		return
	end
	
	local InventoryLayoutOrder = data:Get("InventoryLayoutOrder")
	if not InventoryLayoutOrder then
		InventoryLayoutOrder = {}
	end

	for index, name in pairs(InventoryLayoutOrder) do
		if name == toolName then
			InventoryLayoutOrder[index] = nil
			break
		end
	end
	
	InventoryLayoutOrder[toolIndex] = toolName
	
	data:Set("InventoryLayoutOrder", InventoryLayoutOrder)
end)

return InventoryService