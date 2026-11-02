-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Datas.Mutations)
local v4 = require(v1.Datas.Traits)
local v5 = require(v1.Datas.Animals)
local v_u_6 = require(v1.Datas.Rarities)
local v7 = require(v1.Classes.AnimatedButton)
local v8 = require(v1.Packages.Net)
local v_u_9 = require(v1.Controllers.NotificationController)
local v10 = require(v1.Packages.Synchronizer)
local v_u_11 = v8:RemoteFunction("AdminService/SpawnBrainrotInBase")
local v_u_12 = v8:RemoteFunction("AdminService/ResetBrainrots")
local v_u_13 = v8:RemoteEvent("AdminService/SaveKey")
local v14 = v10:Wait(game.Players.LocalPlayer)
local v_u_14 = script.Parent.Misc.Frame
local v_u_15 = script.Parent.Base.Frame
local v_u_16 = v_u_15.mainMutation
local v_u_17 = v_u_15.mainTrait
local v_u_18 = v_u_15.mainName
local v_u_19 = v_u_15.mainSize
local v20 = v7.new(v_u_15.Spawn)
v20:Animate()
v20.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17, (copy) v_u_19, (copy) v_u_9
	local v21, v22 = v_u_11:InvokeServer(v_u_18.Text, v_u_16.Text, v_u_17.Text, v_u_19.Text)
	if not v21 then
		v_u_9:Error(v22)
	end
end)
local v23 = v7.new(v_u_14.Clear)
v23:Animate()
v23.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_9
	local v24, v25 = v_u_12:InvokeServer()
	if not v24 then
		v_u_9:Error(v25)
	end
end)
local v_u_26 = {}
for v27, v28 in pairs(v3) do
	v_u_26[v27] = v28
	v_u_26[v27].DisplayName = v27
	v_u_26[v27].Color = v28.MainColor
end
local v_u_29 = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for v30, v31 in pairs(v4) do
	v_u_29[v30] = v31
	v_u_29[v30].DisplayName = v30
end
local v_u_32 = {}
for _, v33 in pairs(v5) do
	table.insert(v_u_32, v33)
end
table.sort(v_u_32, function(p34, p35)
	-- upvalues: (copy) v_u_6
	local v36 = p34.Rarity
	local v37 = p35.Rarity
	local v38 = v_u_6[v36].Weight
	local v39 = v_u_6[v37].Weight
	if v38 == v39 then
		return p34.DisplayName < p35.DisplayName
	else
		return v38 < v39
	end
end)
v_u_15.nametext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_32, (copy) v_u_18
	_G.SetAdminContent(v_u_32, function(p40)
		-- upvalues: (ref) v_u_18
		v_u_18.Text = p40
	end)
end)
v_u_15.traittext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_29, (copy) v_u_17
	_G.SetAdminContent(v_u_29, function(p41)
		-- upvalues: (ref) v_u_17
		v_u_17.Text = p41
	end, "multiple", v_u_17.Text)
end)
v_u_15.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_26, (copy) v_u_16
	_G.SetAdminContent(v_u_26, function(p42)
		-- upvalues: (ref) v_u_16
		v_u_16.Text = p42
	end)
end)