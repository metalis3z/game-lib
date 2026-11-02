-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Classes.AnimatedButton)
local v4 = require(v1.Packages.Net)
local v5 = require(v1.Packages.Synchronizer)
local v_u_6 = require(v1.Controllers.NotificationController)
local v_u_7 = v4:RemoteEvent("AdminService/SaveKey")
local v_u_8 = v4:RemoteFunction("AdminService/SetLuck")
local v_u_9 = script.Parent.Luck.Frame
local v10 = v5:Wait(game.Players.LocalPlayer)
local v_u_11 = v_u_9.mainMutation
local v_u_12 = v_u_9.mainName
v5:Wait("Events")
local v13 = v3.new(v_u_9.Set)
v13:Animate()
v13.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_12, (copy) v_u_11, (copy) v_u_6
	local v14, v15 = v_u_8:InvokeServer(v_u_12.Text:gsub("x", ""), v_u_11.Text)
	if v14 then
		v_u_6:Success(v15)
	else
		v_u_6:Error(v15)
	end
end)
local v16 = v3.new(v_u_9.Reset)
v16:Animate()
v16.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_6
	local v17, v18 = v_u_8:InvokeServer(nil, nil, true)
	if v17 then
		v_u_6:Success(v18)
	else
		v_u_6:Error(v18)
	end
end)
local v_u_19 = {
	{
		["DisplayName"] = "x2",
		["Icon"] = "rbxassetid://92074411396710",
		["Color"] = Color3.fromRGB(70, 145, 255)
	},
	{
		["DisplayName"] = "x4",
		["Icon"] = "rbxassetid://90033075589118",
		["Color"] = Color3.fromRGB(110, 200, 110)
	},
	{
		["DisplayName"] = "x6",
		["Icon"] = "rbxassetid://94933198053674",
		["Color"] = Color3.fromRGB(255, 204, 92)
	},
	{
		["DisplayName"] = "x8",
		["Icon"] = "rbxassetid://124799036749678",
		["Color"] = Color3.fromRGB(255, 120, 120)
	},
	{
		["DisplayName"] = "x10",
		["Icon"] = "rbxassetid://137888841783656",
		["Color"] = Color3.fromRGB(189, 189, 189)
	}
}
v_u_9.nametext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_19, (copy) v_u_12
	_G.SetAdminContent(v_u_19, function(p20)
		-- upvalues: (ref) v_u_12
		v_u_12.Text = p20
	end)
end)
local v_u_21 = false
local v_u_22 = nil
local v23 = v10:Get("Keybinds") or {}
local v_u_24
if v23[script.Name] then
	v_u_24 = Enum.KeyCode[v23[script.Name]]
	v_u_9.Set.Key.TextButton.Text = v23[script.Name] or "UNKNOWN"
else
	v_u_24 = nil
end
if v23["Remove Luck"] then
	v_u_22 = Enum.KeyCode[v23["Remove Luck"]]
	v_u_9.Reset.Key.TextButton.Text = v23["Remove Luck"] or "UNKNOWN"
end
v_u_2.InputBegan:Connect(function(p25, p26)
	-- upvalues: (ref) v_u_24, (copy) v_u_8, (copy) v_u_12, (copy) v_u_11, (copy) v_u_6, (ref) v_u_22
	if p26 then
		return
	elseif p25.KeyCode == v_u_24 then
		local v27, v28 = v_u_8:InvokeServer(v_u_12.Text:gsub("x", ""), v_u_11.Text)
		if v27 then
			v_u_6:Success(v28)
		else
			v_u_6:Error(v28)
		end
	else
		if p25.KeyCode == v_u_22 then
			local v29, v30 = v_u_8:InvokeServer(nil, nil, true)
			if v29 then
				v_u_6:Success(v30)
				return
			end
			v_u_6:Error(v30)
		end
		return
	end
end)
v10:OnChanged("Keybinds", function(p31)
	-- upvalues: (ref) v_u_24, (copy) v_u_9, (ref) v_u_22
	local v32
	if p31 then
		v32 = p31[script.Name]
	else
		v32 = p31
	end
	if v32 then
		v_u_24 = Enum.KeyCode[v32]
		v_u_9.Set.Key.TextButton.Text = v32
	else
		v_u_24 = nil
		v_u_9.Set.Key.TextButton.Text = "KEY"
	end
	if p31 then
		p31 = p31["Remove Luck"]
	end
	if p31 then
		v_u_22 = Enum.KeyCode[p31]
		v_u_9.Reset.Key.TextButton.Text = p31
	else
		v_u_22 = nil
		v_u_9.Reset.Key.TextButton.Text = "KEY"
	end
end, true)
v_u_9.Set.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_21, (copy) v_u_9, (copy) v_u_2, (copy) v_u_7, (ref) v_u_24
	if not v_u_21 then
		v_u_21 = true
		v_u_9.Set.Key.TextButton.Text = "..."
		local v_u_33 = nil
		v_u_33 = v_u_2.InputBegan:Connect(function(p34, p35)
			-- upvalues: (ref) v_u_7, (ref) v_u_24, (ref) v_u_33, (ref) v_u_21
			if not p35 then
				if p34.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					local v36 = p34.KeyCode.Name
					v_u_7:FireServer(script.Name, v36)
					v_u_24 = p34.KeyCode or nil
					v_u_33:Disconnect()
					v_u_21 = false
				end
			end
		end)
	end
end)
v_u_9.Reset.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_21, (copy) v_u_9, (copy) v_u_2, (copy) v_u_7, (ref) v_u_22
	if not v_u_21 then
		v_u_21 = true
		v_u_9.Reset.Key.TextButton.Text = "..."
		local v_u_37 = nil
		v_u_37 = v_u_2.InputBegan:Connect(function(p38, p39)
			-- upvalues: (ref) v_u_7, (ref) v_u_22, (ref) v_u_37, (ref) v_u_21
			if not p39 then
				if p38.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_7:FireServer("Remove Luck", p38.KeyCode.Name)
					v_u_22 = p38.KeyCode or nil
					v_u_37:Disconnect()
					v_u_21 = false
				end
			end
		end)
	end
end)
