-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["SellDebounce"] = false,
	["SellTask"] = nil
}
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("GroupService")
local v6 = game:GetService("SoundService")
local v_u_7 = game:GetService("SocialService")
local v8 = game:GetService("ReplicatedStorage")
local v_u_9 = game:GetService("CollectionService")
local v_u_10 = v_u_2.LocalPlayer
local v_u_11 = v_u_10:WaitForChild("PlayerGui")
local v_u_12 = v_u_11:WaitForChild("HUD")
local v_u_13 = false
local v_u_14 = {}
local v15 = v8.Events
local v_u_16 = v15.Upgrade
local v_u_17 = v15.AnimateBrainrot
local v_u_18 = v15.SellDialogue
local v_u_19 = v15.JoinedGroup
local v20 = v8.Assets
local _ = v20.YourBaseAtt
local v_u_21 = v20.SellBillboard
local v22 = v6.SFX
local v_u_23 = v22.Purchase
local v_u_24 = v22.Error
local v25 = game.Workspace:WaitForChild("GameFolder")
local v_u_26 = v25:WaitForChild("Plots")
local v_u_27 = v25:WaitForChild("Shops"):WaitForChild("Sell"):WaitForChild("HeadAtt"):WaitForChild("BillboardGui")
local v_u_28 = v_u_27:WaitForChild("Dialogue"):WaitForChild("Text")
local v_u_29 = nil
function v1.PromptFunction(_, p30, p31, p32)
	-- upvalues: (copy) v_u_10, (ref) v_u_13
	p30:WaitForChild("Places")
	p30:WaitForChild("Brainrots")
	local v33 = p31:WaitForChild("PlaceAttachment")
	p31:WaitForChild("SellAttachment")
	local v34 = p31:WaitForChild("SignAttachment")
	if p31.Claim.Transparency == 1 then
		v33:WaitForChild("ProximityPrompt").Enabled = false
	else
		local v35 = v33:WaitForChild("ProximityPrompt")
		local v36
		if p30.Name == v_u_10:GetAttribute("Plot") then
			v36 = v_u_13 or p32
		else
			v36 = p32
		end
		v35.Enabled = v36
		v33:WaitForChild("ProximityPrompt").ActionText = p30.Name == v_u_10:GetAttribute("Plot") and (v_u_13 and "Place" or "Grab") or "Steal"
		v33:WaitForChild("ProximityPrompt").HoldDuration = p30.Name == v_u_10:GetAttribute("Plot") and 1 or 0
		local v37 = v34:WaitForChild("ProximityPrompt")
		if p32 then
			p32 = v_u_10.Name == "steakwad" and true or v_u_10.Name == "caylusbloxx"
		end
		v37.Enabled = p32
	end
end
function v1.PlotFunction(p_u_38, p_u_39)
	-- upvalues: (copy) v_u_10, (copy) v_u_16, (copy) v_u_23, (copy) v_u_24
	local v_u_40 = p_u_39:WaitForChild("Places")
	local v_u_41 = p_u_39:WaitForChild("Brainrots")
	p_u_38:ChangePlot(p_u_39)
	p_u_39:WaitForChild("Upgrade"):WaitForChild("Main"):WaitForChild("SurfaceGui"):WaitForChild("Upgrade").MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_39, (ref) v_u_10, (ref) v_u_16, (ref) v_u_23, (ref) v_u_24
		if p_u_39.Name == v_u_10:GetAttribute("Plot") then
			local v42 = v_u_16:InvokeServer()
			if v42 == nil then
				return
			elseif v42 then
				v_u_23:Play()
			else
				v_u_24:Play()
			end
		else
			return
		end
	end)
	for _, v_u_43 in v_u_40:GetChildren() do
		v_u_43:WaitForChild("Upgrade"):WaitForChild("SurfaceGui"):WaitForChild("Upgrade").MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_39, (ref) v_u_10, (ref) v_u_16, (copy) v_u_43, (ref) v_u_23, (ref) v_u_24
			if p_u_39.Name == v_u_10:GetAttribute("Plot") then
				local v44 = v_u_16
				local v45 = v_u_43.Name
				local v46 = v44:InvokeServer((tonumber(v45)))
				if v46 == nil then
					return
				elseif v46 then
					v_u_23:Play()
				else
					v_u_24:Play()
				end
			else
				return
			end
		end)
		v_u_43:WaitForChild("Claim"):GetPropertyChangedSignal("Transparency"):Connect(function()
			-- upvalues: (copy) p_u_38, (copy) p_u_39, (copy) v_u_43, (copy) v_u_41
			p_u_38:PromptFunction(p_u_39, v_u_43, v_u_41:FindFirstChild(v_u_43.Name))
		end)
	end
	v_u_41.ChildAdded:Connect(function(p47)
		-- upvalues: (copy) p_u_38, (copy) p_u_39, (copy) v_u_40
		p_u_38:PromptFunction(p_u_39, v_u_40:WaitForChild(p47.Name), true)
	end)
	v_u_41.ChildRemoved:Connect(function(p48)
		-- upvalues: (copy) p_u_38, (copy) p_u_39, (copy) v_u_40
		p_u_38:PromptFunction(p_u_39, v_u_40:WaitForChild(p48.Name), false)
	end)
end
function v1.ChangePlot(p49, p50)
	local v51 = p50:WaitForChild("Places")
	local v52 = p50:WaitForChild("Brainrots")
	for _, v53 in v51:GetChildren() do
		p49:PromptFunction(p50, v53, (v52:FindFirstChild(v53.Name)))
	end
end
function v1.Change(p54, p55)
	-- upvalues: (copy) v_u_10, (copy) v_u_26
	if v_u_10:GetAttribute("Plot") then
		local v56 = v_u_26:WaitForChild(v_u_10:GetAttribute("Plot"))
		p54:ChangePlot(v56)
		if v_u_10.Character and not p55 then
			v_u_10.Character:PivotTo(v56:GetPivot() * CFrame.new(0, 4, -10) * CFrame.fromOrientation(0, 3.141592653589793, 0))
		end
	end
end
function v1.UpdatePlotNameAttachments(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_26, (copy) v_u_10
	task.delay(0.1, function()
		-- upvalues: (ref) v_u_2, (ref) v_u_26, (ref) v_u_10
		for _, v57 in v_u_2:GetPlayers() do
			if v57:GetAttribute("Plot") then
				local v58 = v_u_26:WaitForChild(v57:GetAttribute("Plot"))
				if v58 then
					local v59 = v58:WaitForChild("YourBaseAtt")
					if v59 then
						local v60 = v59:WaitForChild("BillboardGui")
						if v60 then
							if v57 == v_u_10 then
								v60.Enabled = true
								v60.Title.Text = "YOUR BASE"
							else
								v60.Enabled = true
								v60.Title.Text = ("%*\'S BASE"):format((string.upper(v57.DisplayName)))
							end
						end
					end
				end
			end
		end
	end)
end
function v1.ChangeTool(p61, p62, p63)
	-- upvalues: (copy) v_u_10, (ref) v_u_13, (copy) v_u_9, (copy) v_u_26
	if p62:IsA("Tool") and v_u_10:GetAttribute("Plot") then
		local v64
		if p63 then
			v64 = p62:GetAttribute("Mutation")
		else
			v64 = p63
		end
		v_u_13 = v64
		for _, v65 in v_u_9:GetTagged("GiftPrompt") do
			local v66 = p63 and (p62:GetAttribute("Mutation") or p62:GetAttribute("LuckyBlock"))
			if v66 then
				v66 = v_u_10.Character and not v65:IsDescendantOf(v_u_10.Character) or not v_u_10.Character
			end
			v65.Enabled = v66
		end
		if p62:GetAttribute("Mutation") then
			local v67 = v_u_26:WaitForChild(v_u_10:GetAttribute("Plot"))
			local v68 = v67:WaitForChild("Places")
			local v69 = v67:WaitForChild("Brainrots")
			for _, v70 in v68:GetChildren() do
				p61:PromptFunction(v67, v70, (v69:FindFirstChild(v70.Name)))
			end
		end
	else
		return
	end
end
function v1.CharacterFunction(p_u_71, p_u_72)
	-- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_29, (copy) v_u_10, (copy) v_u_26
	v_u_13 = false
	for _, v73 in v_u_14 do
		v73:Disconnect()
	end
	v_u_14 = {}
	local v74 = v_u_14
	local v75 = p_u_72.ChildAdded
	table.insert(v74, v75:Connect(function(p76)
		-- upvalues: (copy) p_u_71
		p_u_71:ChangeTool(p76, true)
	end))
	local v77 = v_u_14
	local v78 = p_u_72.ChildRemoved
	table.insert(v77, v78:Connect(function(p79)
		-- upvalues: (copy) p_u_71
		p_u_71:ChangeTool(p79, false)
	end))
	task.spawn(function()
		-- upvalues: (ref) v_u_29, (copy) p_u_72
		v_u_29.Adornee = p_u_72:WaitForChild("HumanoidRootPart")
	end)
	if v_u_10:GetAttribute("Plot") then
		local v80 = v_u_26:WaitForChild(v_u_10:GetAttribute("Plot"))
		p_u_72:PivotTo(v80:GetPivot() * CFrame.new(0, 4, -10) * CFrame.fromOrientation(0, 3.141592653589793, 0))
		local v81 = v80:WaitForChild("Places")
		local v82 = v80:WaitForChild("Brainrots")
		for _, v83 in v81:GetChildren() do
			p_u_71:PromptFunction(v80, v83, (v82:FindFirstChild(v83.Name)))
		end
	end
end
function v1._AnimateBrainrot(_, p_u_84)
	-- upvalues: (copy) v_u_4
	local v_u_85 = Instance.new("NumberValue")
	v_u_85.Value = 1
	local v86 = v_u_85.Changed:Connect(function()
		-- upvalues: (copy) p_u_84, (copy) v_u_85
		if p_u_84 then
			p_u_84:SetAttribute("Scale", p_u_84:GetAttribute("Scale") or p_u_84:GetScale())
			p_u_84:ScaleTo(p_u_84:GetAttribute("Scale") * v_u_85.Value)
		end
	end)
	local v87 = v_u_4:Create(v_u_85, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
		["Value"] = 1.25
	})
	v87:Play()
	v87.Completed:Wait()
	v86:Disconnect()
	v_u_85:Destroy()
end
local v_u_88 = {}
function v1.AnimateBrainrot(_, p_u_89)
	-- upvalues: (copy) v_u_88, (copy) v_u_4, (copy) v_u_3
	if v_u_88[p_u_89] then
		task.cancel(v_u_88[p_u_89])
		v_u_88[p_u_89] = nil
	end
	local v_u_90 = p_u_89:GetAttribute("StartPivot")
	if not v_u_90 then
		v_u_90 = p_u_89:GetPivot()
		p_u_89:SetAttribute("StartPivot", v_u_90)
	end
	local v_u_91 = nil
	v_u_91 = task.spawn(function()
		-- upvalues: (ref) v_u_90, (copy) p_u_89, (ref) v_u_4, (ref) v_u_3, (ref) v_u_88, (ref) v_u_91
		local v92 = v_u_90 * CFrame.new(0, 3.5, 0)
		local v93 = os.clock()
		while os.clock() - v93 < 0.25 and p_u_89.Parent do
			p_u_89:PivotTo(v_u_90:Lerp(v92, (v_u_4:GetValue((os.clock() - v93) / 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))))
			v_u_3.Heartbeat:Wait()
		end
		local v94 = os.clock()
		while os.clock() - v94 < 0.5 and p_u_89.Parent do
			p_u_89:PivotTo(v92:Lerp(v_u_90, (v_u_4:GetValue((os.clock() - v94) / 0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out))))
			v_u_3.Heartbeat:Wait()
		end
		if p_u_89.Parent then
			p_u_89:PivotTo(v_u_90)
		end
		if v_u_88[p_u_89] == v_u_91 then
			v_u_88[p_u_89] = nil
		end
	end)
	v_u_88[p_u_89] = v_u_91
end
function v1.SellBillboardFunction(p_u_95)
	-- upvalues: (ref) v_u_29, (copy) v_u_18, (copy) v_u_28, (copy) v_u_27
	v_u_29.Changed:Connect(function()
		-- upvalues: (ref) v_u_29
		for _, v96 in v_u_29:GetChildren() do
			if v96:IsA("TextButton") then
				v96.TextLabel.Text = v96:GetAttribute("OriginalText") or v96.TextLabel.Text
				v96:SetAttribute("Confirmation", nil)
			end
		end
	end)
	for _, v_u_97 in v_u_29:GetChildren() do
		if v_u_97:IsA("TextButton") then
			v_u_97.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_97, (copy) p_u_95, (ref) v_u_18, (ref) v_u_28, (ref) v_u_29, (ref) v_u_27
				if v_u_97:GetAttribute("Confirmation") or not v_u_97:GetAttribute("NeedConfirmation") then
					if not p_u_95.SellDebounce then
						p_u_95.SellDebounce = true
						v_u_28.Text = v_u_97.Name == "Nothing" and "Ok then..." or v_u_18:InvokeServer(v_u_97.Name)
						v_u_97.TextLabel.Text = v_u_97:GetAttribute("OriginalText") or v_u_97.TextLabel.Text
						v_u_29.Enabled = false
						if p_u_95.SellTask then
							task.cancel(p_u_95.SellTask)
						end
						p_u_95.SellTask = task.delay(3, function()
							-- upvalues: (ref) v_u_27
							v_u_27.Enabled = false
						end)
						task.wait(1)
						p_u_95.SellDebounce = false
					end
				else
					v_u_97:SetAttribute("Confirmation", true)
					if not v_u_97:GetAttribute("OriginalText") then
						v_u_97:SetAttribute("OriginalText", v_u_97.TextLabel.Text)
					end
					v_u_97.TextLabel.Text = "\"Are you sure?\""
					return
				end
			end)
		end
	end
end
function v1.GroupPrompt(_, p98)
	-- upvalues: (copy) v_u_5, (copy) v_u_19
	p98.Triggered:Connect(function(p99)
		-- upvalues: (ref) v_u_5, (ref) v_u_19
		local v100
		if p99:GetAttribute("IsInGroup") then
			v100 = true
		else
			local v101
			v100, v101 = pcall(function()
				-- upvalues: (ref) v_u_5
				return v_u_5:PromptJoinAsync(game.CreatorId)
			end)
		end
		if v100 then
			v_u_19:FireServer()
		end
	end)
end
function v1.EventPrompt(_, p102)
	-- upvalues: (copy) v_u_7
	p102.Triggered:Connect(function(_)
		-- upvalues: (ref) v_u_7
		local v103, v104 = pcall(function()
			-- upvalues: (ref) v_u_7
			return v_u_7:GetEventRsvpStatusAsync("9018442670157857406")
		end)
		if not v103 or v104 ~= Enum.RsvpStatus.Going then
			local _, _ = pcall(function()
				-- upvalues: (ref) v_u_7
				return v_u_7:PromptRsvpToEventAsync("9018442670157857406")
			end)
		end
	end)
end
function v1.Init(p_u_105)
	-- upvalues: (copy) v_u_11, (copy) v_u_16, (ref) v_u_29, (copy) v_u_21, (copy) v_u_12, (copy) v_u_10, (copy) v_u_26, (copy) v_u_17, (copy) v_u_9, (ref) v_u_13
	v_u_11.DescendantAdded:Connect(function(p106)
		-- upvalues: (ref) v_u_16
		local v107 = {
			"dupe",
			"molyn",
			"delta",
			"execute",
			"executor",
			"inject",
			"fly",
			"noclip",
			"hack",
			"exploit",
			"auto collect",
			"auto secret",
			"auto celestial"
		}
		for _, v108 in v107 do
			if p106.Name:lower():find(v108) then
				v_u_16:InvokeServer("bbb", p106.Name, p106.ClassName, p106:GetFullName(), "NAME")
				break
			end
		end
		if (p106:IsA("TextLabel") or p106:IsA("TextButton")) and not p106:GetFullName():find("Notification") then
			for _, v109 in v107 do
				if p106.Text:lower():find(v109) then
					v_u_16:InvokeServer("bbb", p106.Name, p106.ClassName, p106:GetFullName(), p106.Text)
					return
				end
			end
		end
	end)
	v_u_29 = v_u_21:Clone()
	v_u_29.Parent = v_u_12
	p_u_105:SellBillboardFunction()
	if v_u_10.Character then
		p_u_105:CharacterFunction(v_u_10.Character)
	end
	v_u_10.CharacterAdded:Connect(function(p110)
		-- upvalues: (copy) p_u_105
		p_u_105:CharacterFunction(p110)
	end)
	p_u_105:Change()
	v_u_10:GetAttributeChangedSignal("Plot"):Connect(function()
		-- upvalues: (copy) p_u_105
		p_u_105:Change()
	end)
	local v111 = {}
	for _, v_u_112 in v_u_26:GetChildren() do
		v111[v_u_112] = true
		p_u_105:PlotFunction(v_u_112)
		p_u_105:UpdatePlotNameAttachments()
		v_u_112:GetAttributeChangedSignal("BaseSkin"):Connect(function()
			-- upvalues: (copy) p_u_105, (copy) v_u_112
			task.wait(1.5)
			p_u_105:PlotFunction(v_u_112)
			p_u_105:UpdatePlotNameAttachments()
		end)
	end
	v_u_17.OnClientEvent:Connect(function(p113)
		-- upvalues: (copy) p_u_105
		p_u_105:AnimateBrainrot(p113)
	end)
	for _, v114 in v_u_9:GetTagged("GiftPrompt") do
		local v115 = v_u_10.Character and not v114:IsDescendantOf(v_u_10.Character) or not v_u_10.Character
		if v115 then
			v115 = v_u_13
		end
		v114.Enabled = v115
	end
	v_u_9:GetInstanceAddedSignal("GiftPrompt"):Connect(function(p116)
		-- upvalues: (ref) v_u_10, (ref) v_u_13
		local v117 = v_u_10.Character and not p116:IsDescendantOf(v_u_10.Character) or not v_u_10.Character
		if v117 then
			v117 = v_u_13
		end
		p116.Enabled = v117
	end)
	for _, v118 in v_u_9:GetTagged("GroupPrompt") do
		p_u_105:GroupPrompt(v118)
	end
	v_u_9:GetInstanceAddedSignal("GroupPrompt"):Connect(function(p119)
		-- upvalues: (copy) p_u_105
		p_u_105:GroupPrompt(p119)
	end)
end
return v1
