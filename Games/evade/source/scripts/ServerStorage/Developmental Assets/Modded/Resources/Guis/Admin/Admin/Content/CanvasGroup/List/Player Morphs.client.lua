-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Packages.Synchronizer)
local v4 = require(v1.Packages.Net)
local v5 = require(v1.Classes.AnimatedButton)
local v6 = v3:Wait(game.Players.LocalPlayer)
local v_u_7 = script.Parent.PlrMorph.Frame
local v_u_8 = v4:RemoteEvent("AdminService/PlayerMorph")
local v_u_9 = v4:RemoteEvent("AdminService/SaveKey")
local v10 = v5.new(v_u_7.Morph)
v10:Animate()
v10.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_7
	v_u_8:FireServer(v_u_7.mainName.Text, v_u_7.mainMutation.Text, v_u_7.mainBase.Text, v_u_7.mainHead.Text, v_u_7.mainVerify.Text)
end)
local v11 = v5.new(v_u_7.Unmorph)
v11:Animate()
v11.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_8
	v_u_8:FireServer(true)
end)
local v_u_12 = {
	["Yes"] = {
		["Color"] = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "Yes"
	},
	["No"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "No"
	}
}
v_u_7.verifytext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_7
	_G.SetAdminContent(v_u_12, function(p13)
		-- upvalues: (ref) v_u_7
		v_u_7.mainVerify.Text = p13
	end)
end)
local v_u_14 = false
local v_u_15 = nil
local v16 = v6:Get("Keybinds") or {}
local v_u_17
if v16.PlayerMorphsMorph then
	v_u_17 = Enum.KeyCode[v16.PlayerMorphsMorph]
	script.Parent.Time.Frame.Start.Key.TextButton.Text = v16.PlayerMorphsMorph or "UNKNOWN"
else
	v_u_17 = nil
end
if v16.WeatherControllerStop then
	v_u_15 = Enum.KeyCode[v16.WeatherControllerStop]
	script.Parent.Time.Frame.Stop.Key.TextButton.Text = v16.WeatherControllerStop or "UNKNOWN"
end
v_u_2.InputBegan:Connect(function(p18, p19)
	-- upvalues: (ref) v_u_17, (copy) v_u_8, (copy) v_u_7, (ref) v_u_15
	if p19 then
		return
	elseif p18.KeyCode == v_u_17 then
		v_u_8:FireServer(v_u_7.mainName.Text, v_u_7.mainMutation.Text, v_u_7.mainBase.Text, v_u_7.mainHead.Text, v_u_7.mainVerify.Text)
	elseif p18.KeyCode == v_u_15 then
		v_u_8:FireServer(true)
	end
end)
v6:OnChanged("Keybinds", function(p20)
	-- upvalues: (ref) v_u_17, (ref) v_u_15
	local v21
	if p20 then
		v21 = p20.PlayerMorphsMorph
	else
		v21 = p20
	end
	if p20 then
		p20 = p20.PlayerMorphsUnMorph
	end
	if v21 then
		v_u_17 = Enum.KeyCode[v21]
		script.Parent.PlrMorph.Frame.Morph.Key.TextButton.Text = v21
	else
		v_u_17 = nil
		script.Parent.PlrMorph.Frame.Morph.Key.TextButton.Text = "KEY"
	end
	if p20 then
		v_u_15 = Enum.KeyCode[p20]
		script.Parent.PlrMorph.Frame.Unmorph.Key.TextButton.Text = p20
	else
		v_u_15 = nil
		script.Parent.PlrMorph.Frame.Unmorph.Key.TextButton.Text = "KEY"
	end
end, true)
script.Parent.PlrMorph.Frame.Morph.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_14, (copy) v_u_2, (copy) v_u_9, (ref) v_u_17
	if not v_u_14 then
		v_u_14 = true
		script.Parent.PlrMorph.Frame.Morph.Key.TextButton.Text = "..."
		local v_u_22 = nil
		v_u_22 = v_u_2.InputBegan:Connect(function(p23, p24)
			-- upvalues: (ref) v_u_9, (ref) v_u_17, (ref) v_u_22, (ref) v_u_14
			if not p24 then
				if p23.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_9:FireServer("PlayerMorphsMorph", p23.KeyCode.Name)
					v_u_17 = p23.KeyCode or nil
					v_u_22:Disconnect()
					v_u_14 = false
				end
			end
		end)
	end
end)
script.Parent.PlrMorph.Frame.Unmorph.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_14, (copy) v_u_2, (copy) v_u_9, (ref) v_u_15
	if not v_u_14 then
		v_u_14 = true
		script.Parent.PlrMorph.Frame.Unmorph.Key.TextButton.Text = "..."
		local v_u_25 = nil
		v_u_25 = v_u_2.InputBegan:Connect(function(p26, p27)
			-- upvalues: (ref) v_u_9, (ref) v_u_15, (ref) v_u_25, (ref) v_u_14
			if not p27 then
				if p26.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_9:FireServer("PlayerMorphsUnMorph", p26.KeyCode.Name)
					v_u_15 = p26.KeyCode or nil
					v_u_25:Disconnect()
					v_u_14 = false
				end
			end
		end)
	end
end)
