local FuseMachineLuck = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NotificationService = require(game.ServerScriptService.Services.NotificationService)
local Trove = require(ReplicatedStorage.Packages.Trove)

local currentTrove = nil
local isActive = false

function FuseMachineLuck.OnStart()
	if isActive then return end
	isActive = true

	currentTrove = Trove.new()

	ReplicatedStorage:SetAttribute("FuseMachineLuck", true)
	currentTrove:Add(function()
		ReplicatedStorage:SetAttribute("FuseMachineLuck", nil)
	end)

	local FuseType = workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType")
	local MachineColor = "#00BFFF"

	if FuseType == "Normal" then
		MachineColor = "#00BFFF"
	elseif FuseType == "Divine" then
		MachineColor = "#FFD700"
	elseif FuseType == "Witch" then
		MachineColor = "#9B30FF"
	elseif FuseType == "Santa" then
		MachineColor = "#FF0000"
	elseif FuseType == "Summer" then
		MachineColor = "#e1bb62"
	end

	local message = string.format("Sammy activated <font color='%s'>Fuse Machine Luck</font>!", MachineColor)
	NotificationService.Broadcast(message, 5, "Sounds.Sfx.Success")
end

function FuseMachineLuck.OnStop()
	if not isActive then return end
	isActive = false

	if currentTrove then
		currentTrove:Destroy()
		currentTrove = nil
	end
end

return FuseMachineLuck