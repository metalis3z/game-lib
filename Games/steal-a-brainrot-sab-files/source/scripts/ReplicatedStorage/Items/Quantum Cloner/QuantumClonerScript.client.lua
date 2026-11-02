
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
game:GetService("StarterPlayer")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local QuantumCloner = Players.LocalPlayer.PlayerGui:WaitForChild("ToolsFrames").QuantumCloner
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
require(Controllers.CharacterController)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Debounce = require(Packages.Debounce)
local v1 = script.Parent
local v2 = v1.Parent.Parent
local v3 = nil
v1.Activated:Connect(function()
	local LocalPlayer = game.Players.LocalPlayer
	Net:RemoteEvent("UseItem"):FireServer()
end)
v1.Equipped:Connect(function()
	v3 = RunService.Heartbeat:Connect(function()
		debug.profilebegin("QuantumCloner:Update")
		if workspace:FindFirstChild((("%*_Clone"):format(v2.UserId))) then
			QuantumCloner.Visible = true
		end
		debug.profileend()
	end)
end)
v1.Unequipped:Connect(function()
	if not v3 then
		QuantumCloner.Visible = false
		return
	end
	v3:Disconnect()
	QuantumCloner.Visible = false
end)
v2.CharacterAdded:Connect(function()
	QuantumCloner.Visible = false
	if not v3 then
		return
	end
	v3:Disconnect()
end)
QuantumCloner.TeleportToClone.MouseButton1Up:Connect(function()
	if not Debounce(("ItemUse/QuantumClonerTeleport/%*"):format(v2.Name), 5) then
		Net:RemoteEvent("QuantumCloner/OnTeleport"):FireServer()
	end
end)