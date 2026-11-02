


game:GetService("StarterPlayer")
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local v2 = v_u_1:WaitForChild("Packages")
local v_u_3 = require(v2.Net)
local v4 = script.Parent
local _ = v4.Parent.Parent
v4.Activated:Connect(function()
	local _ = game.Players.LocalPlayer
	local v5 = require(v_u_1.Packages.PlayerMouse)
	v_u_3:RemoteEvent("UseItem"):FireServer(v5.Hit.Position, v5.Target)
end)
