-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Packages.Net)
local v4 = require(v1.Classes.AnimatedButton)
local v5 = require(v1.Packages.Synchronizer)
local v_u_6 = require(v1.Controllers.NotificationController)
local v_u_7 = require(script.Parent.Freecam)
local v_u_8 = v3:RemoteEvent("AdminService/ResetData")
local v_u_9 = v3:RemoteEvent("AdminService/SaveKey")
local v_u_10 = v3:RemoteEvent("AdminService/ResetKeys")
local v_u_11 = v3:RemoteFunction("AdminService/MaxLuck")
local v_u_12 = v3:RemoteFunction("AdminService/ModdedBrainrots")
local v13 = v5:Wait(game.Players.LocalPlayer)
local v_u_14 = nil
script.Parent.Misc.Frame.Freecam.Visible = not v_u_2.TouchEnabled
for _, v16 in pairs(script.Parent:GetDescendants()) do
	if v16:IsA("Frame") and v16.Name == "Key" then
		v16.Visible = not v_u_2.TouchEnabled
	end
end
local v17 = v4.new(script.Parent.Misc.Frame.Freecam)
v17:Animate()
v17.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_7
	v_u_7.Start()
end)
local v20 = v4.new(script.Parent.Misc.Frame.MaxLuck)
v20:Animate()
v20.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_6
	local v21, v22 = v_u_11:InvokeServer()
	if v21 then
		if script.Parent.Misc.Frame.MaxLuck.BackgroundColor3 == Color3.fromRGB(81, 158, 86) then
			script.Parent.Misc.Frame.MaxLuck.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
			script.Parent.Misc.Frame.MaxLuck.UIStroke.Color = Color3.fromRGB(48, 0, 0)
		else
			script.Parent.Misc.Frame.MaxLuck.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
			script.Parent.Misc.Frame.MaxLuck.UIStroke.Color = Color3.fromRGB(0, 85, 0)
		end
	else
		v_u_6:Error(v22)
		return
	end
end)
local v23 = v4.new(script.Parent.Misc.Frame.ModdedBrainrots)
v23:Animate()
v23.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_6
	local v24, v25 = v_u_12:InvokeServer()
	if v24 then
		if script.Parent.Misc.Frame.ModdedBrainrots.BackgroundColor3 == Color3.fromRGB(81, 158, 86) then
			script.Parent.Misc.Frame.ModdedBrainrots.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
			script.Parent.Misc.Frame.ModdedBrainrots.UIStroke.Color = Color3.fromRGB(48, 0, 0)
		else
			script.Parent.Misc.Frame.ModdedBrainrots.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
			script.Parent.Misc.Frame.ModdedBrainrots.UIStroke.Color = Color3.fromRGB(0, 85, 0)
		end
	else
		v_u_6:Error(v25)
		return
	end
end)