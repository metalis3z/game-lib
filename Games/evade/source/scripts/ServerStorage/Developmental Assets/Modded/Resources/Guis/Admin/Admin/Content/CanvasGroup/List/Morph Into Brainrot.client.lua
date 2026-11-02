-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Datas.Mutations)
local v4 = require(v1.Datas.Traits)
local v5 = require(v1.Datas.Animals)
local v_u_6 = require(v1.Datas.Rarities)
require(v1.Shared.Animals)
local v7 = require(v1.Classes.AnimatedButton)
local v8 = require(v1.Packages.Net)
local v_u_9 = require(v1.Controllers.NotificationController)
local v10 = require(v1.Packages.Synchronizer)
local v_u_11 = v8:RemoteFunction("AdminService/Morph")
local v_u_12 = v8:RemoteFunction("AdminService/UnMorph")
local v_u_13 = v8:RemoteEvent("AdminService/SaveKey")
local v_u_14 = script.Parent.Morph.Frame
local v15 = v10:Wait(game.Players.LocalPlayer)
assert(v15)
local v_u_16 = v_u_14.mainMutation
local v_u_17 = v_u_14.mainTrait
local v_u_18 = v_u_14.mainName
local v_u_19 = v_u_14.mainSpeed
local v_u_20 = v_u_14.mainHead
for _, v21 in pairs(workspace:GetDescendants()) do
	if v21:IsA("Model") and (v21:GetAttribute("Index") and (v21:GetAttribute("NoOverhead") and v21.PrimaryPart)) then
		v21.PrimaryPart:WaitForChild("Info"):WaitForChild("AnimalOverhead").Enabled = false
	end
end
workspace.DescendantAdded:Connect(function(p22)
	if p22:IsA("Model") and (p22:GetAttribute("Index") and (p22:GetAttribute("NoOverhead") and p22.PrimaryPart)) then
		p22.PrimaryPart:WaitForChild("Info"):WaitForChild("AnimalOverhead").Enabled = false
	end
end)
local v23 = v7.new(v_u_14.Morph)
v23:Animate()
v23.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17, (copy) v_u_19, (copy) v_u_20, (copy) v_u_9
	local v24, v25 = v_u_11:InvokeServer(v_u_18.Text, v_u_16.Text, v_u_17.Text, v_u_19.Text, v_u_20.Text)
	if not v24 then
		v_u_9:Error(v25)
	end
end)
local v26 = v7.new(v_u_14.Unmorph)
v26:Animate()
v26.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_9
	local v27, v28 = v_u_12:InvokeServer()
	if not v27 then
		v_u_9:Error(v28)
	end
end)
local v_u_29 = {}
for v30, v31 in pairs(v3) do
	v_u_29[v30] = v31
	v_u_29[v30].DisplayName = v30
	v_u_29[v30].Color = v31.MainColor
end
local v_u_32 = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for v33, v34 in pairs(v4) do
	v_u_32[v33] = v34
	v_u_32[v33].DisplayName = v33
end
local v_u_35 = {
	["Yes"] = {
		["Color"] = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "Yes"
	},
	["No"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "No"
	}
}
local v_u_36 = {}
for _, v37 in pairs(v5) do
	table.insert(v_u_36, v37)
end
table.sort(v_u_36, function(p38, p39)
	-- upvalues: (copy) v_u_6
	local v40 = p38.Rarity
	local v41 = p39.Rarity
	local v42 = v_u_6[v40].Weight
	local v43 = v_u_6[v41].Weight
	if v42 == v43 then
		return p38.DisplayName < p39.DisplayName
	else
		return v42 < v43
	end
end)
v_u_14.nametext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_36, (copy) v_u_18
	_G.SetAdminContent(v_u_36, function(p44)
		-- upvalues: (ref) v_u_18
		v_u_18.Text = p44
	end)
end)
v_u_14.traittext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_32, (copy) v_u_17
	_G.SetAdminContent(v_u_32, function(p45)
		-- upvalues: (ref) v_u_17
		v_u_17.Text = p45
	end, "multiple", v_u_17.Text)
end)
v_u_14.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_29, (copy) v_u_16
	_G.SetAdminContent(v_u_29, function(p46)
		-- upvalues: (ref) v_u_16
		v_u_16.Text = p46
	end)
end)
v_u_14.speedtext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_35, (copy) v_u_19
	_G.SetAdminContent(v_u_35, function(p47)
		-- upvalues: (ref) v_u_19
		v_u_19.Text = p47
	end)
end)
v_u_14.headText.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_35, (copy) v_u_20
	_G.SetAdminContent(v_u_35, function(p48)
		-- upvalues: (ref) v_u_20
		v_u_20.Text = p48
	end)
end)
local v_u_49 = false
local v_u_50 = nil
local v51 = v15:Get("Keybinds") or {}
local v_u_52
if v51.BrainrotMorph then
	v_u_52 = Enum.KeyCode[v51.BrainrotMorph]
	v_u_14.Morph.Key.TextButton.Text = v51.BrainrotMorph or "UNKNOWN"
else
	v_u_52 = nil
end
if v51.BrainrotUnMorph then
	v_u_50 = Enum.KeyCode[v51.BrainrotUnMorph]
	v_u_14.Unmorph.Key.TextButton.Text = v51.BrainrotUnMorph or "UNKNOWN"
end
v15:OnChanged("Keybinds", function(p53)
	-- upvalues: (ref) v_u_52, (copy) v_u_14, (ref) v_u_50
	local v54
	if p53 then
		v54 = p53.BrainrotMorph
	else
		v54 = p53
	end
	if p53 then
		p53 = p53.BrainrotUnMorph
	end
	if v54 then
		v_u_52 = Enum.KeyCode[v54]
		v_u_14.Morph.Key.TextButton.Text = v54
	else
		v_u_52 = nil
		v_u_14.Morph.Key.TextButton.Text = "KEY"
	end
	if p53 then
		v_u_50 = Enum.KeyCode[p53]
		v_u_14.Unmorph.Key.TextButton.Text = p53
	else
		v_u_50 = nil
		v_u_14.Unmorph.Key.TextButton.Text = "KEY"
	end
end, true)
v_u_2.InputBegan:Connect(function(p55, p56)
	-- upvalues: (ref) v_u_52, (copy) v_u_11, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17, (copy) v_u_19, (copy) v_u_20, (copy) v_u_9, (ref) v_u_50, (copy) v_u_12
	if not p56 then
		if p55.KeyCode == v_u_52 then
			local v57, v58 = v_u_11:InvokeServer(v_u_18.Text, v_u_16.Text, v_u_17.Text, v_u_19.Text, v_u_20.Text)
			if not v57 then
				v_u_9:Error(v58)
				return
			end
		elseif p55.KeyCode == v_u_50 then
			local v59, v60 = v_u_12:InvokeServer()
			if not v59 then
				v_u_9:Error(v60)
			end
		end
	end
end)
v_u_14.Morph.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_49, (copy) v_u_14, (copy) v_u_2, (copy) v_u_13, (ref) v_u_52
	if not v_u_49 then
		v_u_49 = true
		v_u_14.Morph.Key.TextButton.Text = "..."
		local v_u_61 = nil
		v_u_61 = v_u_2.InputBegan:Connect(function(p62, p63)
			-- upvalues: (ref) v_u_13, (ref) v_u_52, (ref) v_u_61, (ref) v_u_49
			if not p63 then
				if p62.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_13:FireServer("BrainrotMorph", p62.KeyCode.Name)
					v_u_52 = p62.KeyCode or nil
					v_u_61:Disconnect()
					v_u_49 = false
				end
			end
		end)
	end
end)
v_u_14.Unmorph.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_49, (copy) v_u_14, (copy) v_u_2, (copy) v_u_13, (ref) v_u_50
	if not v_u_49 then
		v_u_49 = true
		v_u_14.Unmorph.Key.TextButton.Text = "..."
		local v_u_64 = nil
		v_u_64 = v_u_2.InputBegan:Connect(function(p65, p66)
			-- upvalues: (ref) v_u_13, (ref) v_u_50, (ref) v_u_64, (ref) v_u_49
			if not p66 then
				if p65.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_13:FireServer("BrainrotUnMorph", p65.KeyCode.Name)
					v_u_50 = p65.KeyCode or nil
					v_u_64:Disconnect()
					v_u_49 = false
				end
			end
		end)
	end
end)
