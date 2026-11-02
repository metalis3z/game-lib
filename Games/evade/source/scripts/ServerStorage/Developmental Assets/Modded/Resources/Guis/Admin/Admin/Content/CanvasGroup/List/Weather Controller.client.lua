-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Lighting")
local v_u_3 = game:GetService("UserInputService")
local v4 = require(v1.Packages.Net)
local v5 = require(v1.Packages.Synchronizer)
local v6 = require(v1.Classes.AnimatedButton)
local v_u_7 = require(v1.Controllers.NotificationController)
local v_u_8 = v4:RemoteEvent("AdminService/SaveKey")
local v9 = v5:Wait(game.Players.LocalPlayer)
local v_u_10 = nil
local function v_u_17()
	-- upvalues: (copy) v_u_7, (ref) v_u_10, (copy) v_u_2
	local v11 = script.Parent.Time.Frame.mainName.Text
	if tonumber(v11) then
		local v12 = game.Lighting
		local v13 = script.Parent.Time.Frame.mainName.Text
		v12.ClockTime = tonumber(v13)
		if v_u_10 then
			v_u_10:Disconnect()
		end
		v_u_10 = v_u_2:GetPropertyChangedSignal("ClockTime"):Connect(function()
			local v14 = script.Parent.Time.Frame.mainName.Text
			if tonumber(v14) then
				local v15 = game.Lighting
				local v16 = script.Parent.Time.Frame.mainName.Text
				v15.ClockTime = tonumber(v16)
			end
		end)
	else
		v_u_7:Error("Please input a valid time in numbers.")
	end
end
local v18 = v6.new(script.Parent.Time.Frame.Start)
v18:Animate()
v18.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_17
	v_u_17()
end)
local v19 = v6.new(script.Parent.Time.Frame.Stop)
v19:Animate()
v19.OnActivated:Connect(function()
	-- upvalues: (ref) v_u_10
	if v_u_10 then
		v_u_10:Disconnect()
	end
end)
local v_u_20 = v_u_10
local v_u_21 = {}
for v22 = 0, 24 do
	v_u_21[v22] = {
		["Color"] = Color3.fromRGB(85, 170, 255),
		["DisplayName"] = tostring(v22),
		["Icon"] = "rbxassetid://96342315014653"
	}
end
local v_u_23 = false
local v_u_24 = nil
local v25 = v9:Get("Keybinds") or {}
local v_u_26
if v25.WeatherControllerStart then
	v_u_26 = Enum.KeyCode[v25.WeatherControllerStart]
	script.Parent.Time.Frame.Start.Key.TextButton.Text = v25.WeatherControllerStart or "UNKNOWN"
else
	v_u_26 = nil
end
if v25.WeatherControllerStop then
	v_u_24 = Enum.KeyCode[v25.WeatherControllerStop]
	script.Parent.Time.Frame.Stop.Key.TextButton.Text = v25.WeatherControllerStop or "UNKNOWN"
end
v_u_3.InputBegan:Connect(function(p27, p28)
	-- upvalues: (ref) v_u_26, (ref) v_u_20, (copy) v_u_17, (ref) v_u_24
	if p28 then
		return
	elseif p27.KeyCode == v_u_26 then
		if v_u_20 then
			v_u_20:Disconnect()
		else
			v_u_17()
		end
	else
		if p27.KeyCode == v_u_24 and v_u_20 then
			v_u_20:Disconnect()
		end
		return
	end
end)
v9:OnChanged("Keybinds", function(p29)
	-- upvalues: (ref) v_u_26, (ref) v_u_24
	local v30
	if p29 then
		v30 = p29.WeatherControllerStart
	else
		v30 = p29
	end
	if p29 then
		p29 = p29.WeatherControllerStop
	end
	if v30 then
		v_u_26 = Enum.KeyCode[v30]
		script.Parent.Time.Frame.Start.Key.TextButton.Text = v30
	else
		v_u_26 = nil
		script.Parent.Time.Frame.Start.Key.TextButton.Text = "KEY"
	end
	if p29 then
		v_u_24 = Enum.KeyCode[p29]
		script.Parent.Time.Frame.Stop.Key.TextButton.Text = p29
	else
		v_u_24 = nil
		script.Parent.Time.Frame.Stop.Key.TextButton.Text = "KEY"
	end
end, true)
script.Parent.Time.Frame.Start.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_23, (copy) v_u_3, (copy) v_u_8, (ref) v_u_26
	if not v_u_23 then
		v_u_23 = true
		script.Parent.Time.Frame.Start.Key.TextButton.Text = "..."
		local v_u_31 = nil
		v_u_31 = v_u_3.InputBegan:Connect(function(p32, p33)
			-- upvalues: (ref) v_u_8, (ref) v_u_26, (ref) v_u_31, (ref) v_u_23
			if not p33 then
				if p32.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_8:FireServer("WeatherControllerStart", p32.KeyCode.Name)
					v_u_26 = p32.KeyCode or nil
					v_u_31:Disconnect()
					v_u_23 = false
				end
			end
		end)
	end
end)
script.Parent.Time.Frame.Stop.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_23, (copy) v_u_3, (copy) v_u_8, (ref) v_u_24
	if not v_u_23 then
		v_u_23 = true
		script.Parent.Time.Frame.Stop.Key.TextButton.Text = "..."
		local v_u_34 = nil
		v_u_34 = v_u_3.InputBegan:Connect(function(p35, p36)
			-- upvalues: (ref) v_u_8, (ref) v_u_24, (ref) v_u_34, (ref) v_u_23
			if not p36 then
				if p35.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_8:FireServer("WeatherControllerStop", p35.KeyCode.Name)
					v_u_24 = p35.KeyCode or nil
					v_u_34:Disconnect()
					v_u_23 = false
				end
			end
		end)
	end
end)
script.Parent.Time.Frame.nametext.ImageButton.TextButton.Activated:Connect(function()
	-- upvalues: (copy) v_u_21
	_G.SetAdminContent(v_u_21, function(p37)
		script.Parent.Time.Frame.mainName.Text = p37
	end)
end)
