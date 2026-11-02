---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
game:GetService("StarterPlayer")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local v_u_4 = v1.LocalPlayer.PlayerGui:WaitForChild("ToolsFrames").QuantumCloner
local v5 = v3:WaitForChild("Controllers")
require(v5.CharacterController)
local v6 = v3:WaitForChild("Packages")
local v_u_7 = require(v6.Net)
local v_u_8 = require(v6.Debounce)
local v9 = script.Parent
local v_u_10 = v9.Parent.Parent
local v_u_11 = nil
v9.Activated:Connect(function()
	-- upvalues: (copy) v_u_7
	local _ = game.Players.LocalPlayer
	v_u_7:RemoteEvent("UseItem"):FireServer()
end)
v9.Equipped:Connect(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_2, (copy) v_u_10, (copy) v_u_4
	v_u_11 = v_u_2.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_4
		debug.profilebegin("QuantumCloner:Update")
		if workspace:FindFirstChild((("%*_Clone"):format(v_u_10.UserId))) then
			v_u_4.Visible = true
		end
		debug.profileend()
	end)
end)
v9.Unequipped:Connect(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_4
	if v_u_11 then
		v_u_11:Disconnect()
	end
	v_u_4.Visible = false
end)
v_u_10.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_4, (ref) v_u_11
	v_u_4.Visible = false
	if v_u_11 then
		v_u_11:Disconnect()
	end
end)
v_u_4.TeleportToClone.MouseButton1Up:Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_7
	if not v_u_8(("ItemUse/QuantumClonerTeleport/%*"):format(v_u_10.Name), 5) then
		v_u_7:RemoteEvent("QuantumCloner/OnTeleport"):FireServer()
	end
end)
