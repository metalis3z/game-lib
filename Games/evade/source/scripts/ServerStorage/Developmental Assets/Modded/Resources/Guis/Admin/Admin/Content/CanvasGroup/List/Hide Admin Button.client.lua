-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("MarketplaceService")
game:GetService("Players")
local v2 = game:GetService("TextChatService")
local v_u_3 = game:GetService("UserInputService")
local v4 = require(v1.Packages.Synchronizer)
local v5 = require(v1.Classes.AnimatedButton)
local v_u_6 = require(v1.Packages.Net):RemoteEvent("AdminService/SaveKey")
local v7 = v4:Wait(game.Players.LocalPlayer)
local v_u_8 = script.Parent.Misc.Frame
local v_u_9 = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons:WaitForChild("Admin")
local v_u_10 = false
local v11 = v5.new(v_u_8.Hide)
v11:Animate()
v11.OnActivated:Connect(function()
	-- upvalues: (ref) v_u_10, (copy) v_u_8, (copy) v_u_9
	v_u_10 = not v_u_10
	if v_u_10 then
		v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
		v_u_9.Visible = false
	else
		v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
		v_u_9.Visible = true
	end
end)
v2:WaitForChild("KiwiGames"):WaitForChild("Admin").Triggered:Connect(function()
	-- upvalues: (ref) v_u_10, (copy) v_u_8, (copy) v_u_9
	v_u_10 = false
	if v_u_10 then
		v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
		v_u_9.Visible = false
	else
		v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
		v_u_9.Visible = true
	end
end)
local v_u_12 = false
local v13 = v7:Get("Keybinds") or {}
local v_u_14
if v13["Hide Button"] then
	v_u_14 = Enum.KeyCode[v13["Hide Button"]]
	script.Parent.Misc.Frame.Hide.Key.TextButton.Text = v13["Hide Button"] or "UNKNOWN"
else
	v_u_14 = nil
end
v7:OnChanged("Keybinds", function(p15)
	-- upvalues: (ref) v_u_14
	if p15 then
		p15 = p15["Hide Button"]
	end
	if p15 then
		v_u_14 = Enum.KeyCode[p15]
		script.Parent.Misc.Frame.Hide.Key.TextButton.Text = p15
	else
		v_u_14 = nil
		script.Parent.Misc.Frame.Hide.Key.TextButton.Text = "KEY"
	end
end, true)
v_u_3.InputBegan:Connect(function(p16, p17)
	-- upvalues: (ref) v_u_14, (ref) v_u_10, (copy) v_u_8, (copy) v_u_9
	if not p17 then
		if p16.KeyCode == v_u_14 then
			v_u_10 = not v_u_10
			if v_u_10 then
				v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
				v_u_9.Visible = false
				return
			end
			v_u_8.Hide.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
			v_u_9.Visible = true
		end
	end
end)
script.Parent.Misc.Frame.Hide.Key.TextButton.Activated:Connect(function()
	-- upvalues: (ref) v_u_12, (copy) v_u_3, (copy) v_u_6, (ref) v_u_14
	if not v_u_12 then
		v_u_12 = true
		script.Parent.Misc.Frame.Hide.Key.TextButton.Text = "..."
		local v_u_18 = nil
		v_u_18 = v_u_3.InputBegan:Connect(function(p19, p20)
			-- upvalues: (ref) v_u_6, (ref) v_u_14, (ref) v_u_18, (ref) v_u_12
			if not p20 then
				if p19.UserInputType == Enum.UserInputType.Keyboard then
					task.wait()
					v_u_6:FireServer("Hide Button", p19.KeyCode.Name)
					v_u_14 = p19.KeyCode or nil
					v_u_18:Disconnect()
					v_u_12 = false
				end
			end
		end)
	end
end)
