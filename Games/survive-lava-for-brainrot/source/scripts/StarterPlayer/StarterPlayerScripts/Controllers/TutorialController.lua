-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["Brainrot"] = nil,
	["Step"] = 1,
	["Connections"] = {},
	["Atts"] = {}
}
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v3.Assets.TutorialAtts
local v_u_6 = v3.Events.Tutorial
local v_u_7 = v2.LocalPlayer
local v8 = v_u_7:WaitForChild("PlayerGui"):WaitForChild("HUD")
v8:WaitForChild("LeftButtons"):WaitForChild("Rebirth")
local v_u_9 = v8:WaitForChild("TutorialNotifications"):WaitForChild("TutorialNotf")
local v_u_10 = v8:WaitForChild("FakeRebirth")
local v11 = game.Workspace:WaitForChild("GameFolder")
local v_u_12 = v11:WaitForChild("Brainrots"):WaitForChild("Common")
local v_u_13 = v11:WaitForChild("Plots")
local v_u_14 = v11:WaitForChild("Shops"):WaitForChild("Speed")
local v_u_15 = require(v3.Modules.DataController)
function v1.Clean(p16)
	-- upvalues: (copy) v_u_4, (copy) v_u_10
	p16.Brainrot = nil
	p16.Step = 1
	v_u_4:Create(v_u_10, TweenInfo.new(0.5), {
		["GroupTransparency"] = 1
	}):Play()
	for _, v17 in p16.Connections do
		v17:Disconnect()
	end
	for _, v18 in p16.Atts do
		v18:Destroy()
	end
	p16.Connections = {}
	p16.Atts = {}
end
function v1.AttachToCharacter(p19)
	-- upvalues: (copy) v_u_7
	local v20 = v_u_7.Character
	if v20 then
		v20 = v20:WaitForChild("HumanoidRootPart")
	end
	if v20 then
		v20 = v20:WaitForChild("RootAttachment")
	end
	if v20 then
		for _, v21 in p19.Atts do
			if v21:FindFirstChild("Beam") then
				v21.Beam.Attachment1 = v20
			end
		end
	end
end
function v1.MakeAttachments(p22, p23)
	-- upvalues: (copy) v_u_5
	local v24 = v_u_5:Clone()
	v24.End.Parent = p23
	v24.Parent = game.Workspace
	local v25 = p22.Atts
	table.insert(v25, v24)
	p22:AttachToCharacter()
end
function v1.GetBrainrot(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_12
	local v26 = nil
	local v27 = v_u_7.Character
	if v27 then
		v27 = v_u_7.Character:GetPivot().Position.Z > -55
	end
	for _, v28 in v_u_12:GetChildren() do
		if v28:FindFirstChild("RootPart") and not v28.RootPart:FindFirstChild("Motor6D") then
			if v27 then
				if not v26 or (v_u_7.Character:GetPivot().Position - v28:GetPivot().Position).Magnitude < (v_u_7.Character:GetPivot().Position - v26:GetPivot().Position).Magnitude then
					v26 = v28
				end
			else
				v26 = v28
			end
		end
	end
	return v26
end
function v1.FindBrainrot(p_u_29)
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_6
	local v30 = v_u_7.Character
	if v30 then
		v30 = v_u_7.Character:GetPivot().Position.Z > -55
	end
	if v30 or (not p_u_29.Brainrot or (not p_u_29.Brainrot:IsDescendantOf(v_u_12) or (not p_u_29.Brainrot:FindFirstChild("RootPart") or p_u_29.Brainrot.RootPart:FindFirstChild("Motor6D")))) then
		for _, v31 in p_u_29.Atts do
			v31:Destroy()
		end
		p_u_29.Atts = {}
		p_u_29.Brainrot = p_u_29:GetBrainrot()
		if p_u_29.Brainrot then
			p_u_29:AttachToBrainrot(p_u_29.Brainrot)
			if p_u_29.Connections.RootPart then
				p_u_29.Connections.RootPart:Disconnect()
			end
			if p_u_29.Connections.Grabbed then
				p_u_29.Connections.Grabbed:Disconnect()
			end
			p_u_29.Connections.RootPart = p_u_29.Brainrot:WaitForChild("RootPart").ChildAdded:Connect(function(p32)
				-- upvalues: (ref) v_u_7, (copy) p_u_29
				if p32.Name == "Motor6D" then
					if not v_u_7.Character or (not v_u_7.Character:FindFirstChild("HumanoidRootPart") or p32.Part0 ~= v_u_7.Character.HumanoidRootPart) then
						p_u_29:FindBrainrot()
					end
				else
					return
				end
			end)
			p_u_29.Connections.Grabbed = v_u_6.OnClientEvent:Connect(function(p33)
				-- upvalues: (copy) p_u_29
				if p33 == "Grab" then
					p_u_29:Clean()
					p_u_29:AttachToPlot()
				end
			end)
		end
	else
		return
	end
end
function v1.AttachToRebirth(p_u_34)
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_4, (copy) v_u_6
	p_u_34.Step = 5
	v_u_9.Text = "Rebirth to Jump Higher"
	v_u_9.Visible = true
	v_u_10.Visible = true
	v_u_4:Create(v_u_10, TweenInfo.new(0.5), {
		["GroupTransparency"] = 0
	}):Play()
	p_u_34.Connections.Clicked = v_u_10.LeftButtons.Rebirth.Activated:Connect(function()
		-- upvalues: (copy) p_u_34, (ref) v_u_6, (ref) v_u_9, (ref) v_u_4, (ref) v_u_10
		p_u_34:Clean()
		v_u_6:FireServer("End")
		v_u_9.Visible = false
		v_u_4:Create(v_u_10, TweenInfo.new(0.5), {
			["GroupTransparency"] = 1
		}):Play()
		task.wait(1)
		v_u_10.Visible = false
	end)
end
function v1.AttachToShop(p_u_35)
	-- upvalues: (copy) v_u_14, (copy) v_u_9, (copy) v_u_6
	p_u_35.Step = 4
	p_u_35:MakeAttachments(v_u_14)
	v_u_9.Text = "Upgrade your Speed"
	v_u_9.Visible = true
	p_u_35.Connections.Upgraded = v_u_6.OnClientEvent:Connect(function(p36)
		-- upvalues: (copy) p_u_35
		if p36 == "Speed" then
			p_u_35:Clean()
			p_u_35:AttachToRebirth()
		end
	end)
end
function v1.AttachToCollect(p_u_37, p38)
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	p_u_37.Step = 3
	p_u_37:MakeAttachments(p38)
	v_u_9.Text = "Get $200 Cash"
	v_u_9.Visible = true
	p_u_37.Connections.Collected = v_u_6.OnClientEvent:Connect(function(p39, p40)
		-- upvalues: (copy) p_u_37
		if p39 == "Cash" and p40 >= 200 then
			p_u_37:Clean()
			p_u_37:AttachToShop()
		end
	end)
end
function v1.AttachToPlot(p_u_41)
	-- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_9, (copy) v_u_6
	p_u_41.Step = 2
	local v42 = v_u_13:WaitForChild(v_u_7:GetAttribute("Plot")):WaitForChild("Places"):WaitForChild("1")
	for v43 = 1, 10 do
		if not v_u_13[v_u_7:GetAttribute("Plot")]:WaitForChild("Brainrots"):FindFirstChild(v43) then
			v42 = v_u_13[v_u_7:GetAttribute("Plot")].Places[v43]
			break
		end
	end
	p_u_41:MakeAttachments(v42)
	v_u_9.Text = "Place it on your Plot"
	v_u_9.Visible = true
	p_u_41.Connections.Placed = v_u_6.OnClientEvent:Connect(function(p44, p45)
		-- upvalues: (copy) p_u_41
		if p44 == "Place" then
			p_u_41:Clean()
			p_u_41:AttachToCollect(p45)
		end
	end)
end
function v1.AttachToBrainrot(p46, p47)
	-- upvalues: (copy) v_u_9
	p46.Step = 1
	if p47 then
		p46:MakeAttachments(p47:WaitForChild("RootPart"))
		v_u_9.Text = "Grab a Brainrot"
		v_u_9.Visible = true
	end
end
function v1.StartTutorial(p_u_48)
	-- upvalues: (copy) v_u_12
	p_u_48:Clean()
	p_u_48:FindBrainrot()
	local v49 = p_u_48.Connections
	local v50 = v_u_12.ChildAdded
	table.insert(v49, v50:Connect(function(_)
		-- upvalues: (copy) p_u_48
		p_u_48:FindBrainrot()
	end))
end
function v1.EndTutorial(p51)
	-- upvalues: (copy) v_u_9
	p51:Clean()
	v_u_9.Visible = false
end
function v1.Init(p_u_52)
	-- upvalues: (copy) v_u_15, (copy) v_u_7
	v_u_15:GetPathSignal(v_u_15.PathBuilder.OtherData.TutorialDone):Connect(function()
		-- upvalues: (ref) v_u_15, (copy) p_u_52
		local v53 = v_u_15:GetPlayerDataAsync()
		if v53 then
			if not v53.OtherData.TutorialDone then
				p_u_52:StartTutorial()
			end
		end
	end)
	local v54 = v_u_15:GetPlayerDataAsync()
	if v54 and not v54.OtherData.TutorialDone then
		p_u_52:StartTutorial()
	end
	v_u_7.CharacterAdded:Connect(function()
		-- upvalues: (copy) p_u_52
		if p_u_52.Step == 2 then
			p_u_52:StartTutorial()
		else
			p_u_52:AttachToCharacter()
		end
	end)
end
return v1
