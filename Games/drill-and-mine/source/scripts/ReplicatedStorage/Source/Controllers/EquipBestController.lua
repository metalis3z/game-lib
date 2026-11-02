local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local EquipBestController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PodiumRemotes = Remotes:WaitForChild("PodiumService")
local EquipBestFunc = PodiumRemotes:WaitForChild("EquipBest", 10)

local TopbarPlus = Workspace:FindFirstChild("TopbarPlus")
if not TopbarPlus then
	function EquipBestController.Init() end
	return EquipBestController
end
local Icon = require(TopbarPlus.Icon)

local isRequesting = false

function EquipBestController.Init()
	if not EquipBestFunc then
		warn("EquipBestController: EquipBest remote not found")
		return
	end

	local icon = Icon.new()
		:setLabel("Equip Best")
		:setOrder(10)

	icon:bindEvent("selected", function()
		icon:deselect()
		if isRequesting then return end
		isRequesting = true
		task.spawn(function()
			pcall(function()
				EquipBestFunc:InvokeServer()
			end)
			isRequesting = false
		end)
	end)
end

return EquipBestController
