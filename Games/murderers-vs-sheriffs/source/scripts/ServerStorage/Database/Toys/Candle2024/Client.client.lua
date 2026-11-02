-- Generated using Scripts Dumper by FFJ Hub.
-- Script: https://scriptblox.com/script/Universal-Script-Scripts-Dumper-Decompiler-29954
-- FFJ Hub: https://discord.gg/am4wkrjyKK

-- Decompiled by Krnl

local v_u_1 = game.Players.LocalPlayer
local v_u_2 = v_u_1:GetMouse()
local v3 = script.Parent
local v_u_4 = v3:WaitForChild("RemoteEvent")
local function v_u_8()
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v5 = v_u_2.UnitRay
	local v6 = RaycastParams.new()
	v6.FilterDescendantsInstances = { v_u_1.Character }
	local v7 = workspace:Raycast(v5.Origin, v5.Direction * 50, v6)
	if v7 then
		return v7.Instance, v7.Position
	else
		return nil, nil
	end
end
v3.Activated:Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_4
	local v9, v10 = v_u_8()
	v_u_4:FireServer(v9, v10)
end)
