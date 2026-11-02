-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = require(v1.Packages.Net)
local v4 = require(v1.Classes.AnimatedButton)
local v_u_5 = require(v1.Controllers.NotificationController)
local v6 = require(v1.Packages.Synchronizer)
local v_u_7 = v3:RemoteFunction("AdminService/GiveMulti")
local v_u_8 = v3:RemoteEvent("AdminService/SaveKey")
local v9 = v6:Wait(game.Players.LocalPlayer)
local v10 = v4.new(script.Parent.Multi.Frame.Set)
v10:Animate()
v10.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_5
	local v11 = script.Parent.Multi.Frame.mainMutation.Text
	local v12, v13 = v_u_7:InvokeServer((tonumber(v11)))
	if not v12 then
		v_u_5:Error(v13)
	end
end)
local v14 = v4.new(script.Parent.Multi.Frame.Add)
v14:Animate()
v14.OnActivated:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_5
	local v15 = script.Parent.Multi.Frame.mainMutation.Text
	local v16, v17 = v_u_7:InvokeServer(tonumber(v15), true)
	if not v16 then
		v_u_5:Error(v17)
	end
end)
local v_u_18 = false
local v_u_19 = nil
local v20 = v9:Get("Keybinds") or {}
local v_u_21
if v20.MultiGiverSet then
	v_u_21 = Enum.KeyCode[v20.MultiGiverSet]
	script.Parent.Multi.Frame.Set.Key.TextButton.Text = v20.MultiGiverSet or "UNKNOWN"
else
	v_u_21 = nil
end
if v20.MultiGiverAdd then
	v_u_19 = Enum.KeyCode[v20.MultiGiverAdd]
	script.Parent.Multi.Frame.Add.Key.TextButton.Text = v20.MultiGiverAdd or "UNKNOWN"
end
v9:OnChanged("Keybinds", function(p22)
	-- upvalues: (ref) v_u_21, (ref) v_u_19
	local v23
	if p22 then
		v23 = p22.MultiGiverSet
	else
		v23 = p22
	end
	if p22 then
		p22 = p22.MultiGiverAdd
	end
	if v23 then
		v_u_21 = Enum.KeyCode[v23]
		script.Parent.Multi.Frame.Set.Key.TextButton.Text = v23
	else
		v_u_21 = nil
		script.Parent.Multi.Frame.Set.Key.TextButton.Text = "KEY"
	end
	if p22 then
		v_u_19 = Enum.KeyCode[p22]
		script.Parent.Multi.Frame.Add.Key.TextButton.Text = p22
	else
		v_u_19 = nil
		script.Parent.Multi.Frame.Add.Key.TextButton.Text = "KEY"
	end
end, true)
v_u_2.InputBegan:Connect(function(p24, p25)
	-- upvalues: (ref) v_u_21, (copy) v_u_7, (copy) v_u_5, (ref) v_u_19
	if not p25 then
		if p24.KeyCode == v_u_21 then
			local v26 = script.Parent.Multi.Frame.mainMutation.Text
			local v27, v28 = v_u_7:InvokeServer((tonumber(v26)))
			if not v27 then
				v_u_5:Error(v28)
				return
			end
		elseif p24.KeyCode == v_u_19 then
			local v29 = script.Parent.Multi.Frame.mainMutation.Text
			local v30, v31 = v_u_7:InvokeServer(tonumber(v29), true)
			if not v30 then
				v_u_5:Error(v31)
			end
		end
	end
end)
script.Parent.Multi.Frame.Set.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_18, (copy) v_u_2, (copy) v_u_8, (ref) v_u_21
	if not v_u_18 then
		v_u_18 = true
		script.Parent.Multi.Frame.Set.Key.TextButton.Text = "..."
		local v_u_32 = nil
		v_u_32 = v_u_2.InputBegan:Connect(function(p33, p34)
			-- upvalues: (ref) v_u_8, (ref) v_u_21, (ref) v_u_32, (ref) v_u_18
			if not p34 then
				if p33.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_8:FireServer("MultiGiverSet", p33.KeyCode.Name)
					v_u_21 = p33.KeyCode or nil
					v_u_32:Disconnect()
					v_u_18 = false
				end
			end
		end)
	end
end)
script.Parent.Multi.Frame.Add.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_18, (copy) v_u_2, (copy) v_u_8, (ref) v_u_21
	if not v_u_18 then
		v_u_18 = true
		script.Parent.Multi.Frame.Add.Key.TextButton.Text = "..."
		local v_u_35 = nil
		v_u_35 = v_u_2.InputBegan:Connect(function(p36, p37)
			-- upvalues: (ref) v_u_8, (ref) v_u_21, (ref) v_u_35, (ref) v_u_18
			if not p37 then
				if p36.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_8:FireServer("MultiGiverAdd", p36.KeyCode.Name)
					v_u_21 = p36.KeyCode or nil
					v_u_35:Disconnect()
					v_u_18 = false
				end
			end
		end)
	end
end)
